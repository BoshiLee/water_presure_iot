import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/models/sensor_data.dart';
import 'package:water_pressure_iot/utils/date_helper.dart';

part 'sensors_data_table_state.dart';

class SensorsDataTableCubit extends Cubit<SensorsDataTableState> {
  List<Sensor>? sensors = [];

  List<List<String>> _dataTable = [];

  List<String> get _dataHeader {
    if (sensors == null || sensors!.isEmpty) {
      return [];
    }
    return [
      'UID',
      'Time',
      for (var sensor in sensors!) '${sensor.nameIdentity}',
    ];
  }

  List<List<String>> get _readyToExportTable => [_dataHeader, ..._dataTable];

  String get _exportFileName =>
      'sensor_data_${DateTime.now().iso8601StringWithTimeOffset()}';

  SensorsDataTableCubit({
    required this.sensors,
  }) : super(const SensorsDataTableInitial()) {
    initializeData();
  }

  Future<void> initializeData() async {
    emit(SensorsDataTableLoading());
    try {
      List<SensorData> allData = await compute<List<Sensor>, List<SensorData>>(
        _flatAllSensorData,
        sensors!,
      );
      _dataTable = await compute<List<SensorData>, List<List<String>>>(
        _generateDataTable,
        allData,
      );
    } on Exception catch (e) {
      emit(SensorsDataTableError(message: e.toString()));
    } finally {
      emit(
        SensorsDataTableLoaded(
          dataHeader: _dataHeader,
          dataTable: _dataTable,
        ),
      );
    }
  }

  List<SensorData> _flatAllSensorData(List<Sensor> sensors) {
    List<SensorData> flatData = [];
    for (var sensor in sensors) {
      flatData.addAll(sensor.sensorData ?? []);
    }
    return flatData;
  }

  List<List<String>> _generateDataTable(List<SensorData> allData) {
    if (sensors == null || sensors!.isEmpty) {
      return [];
    }
    Map<String, int> sensorDataMap = {};

    sensors?.asMap().forEach((index, sensor) {
      sensorDataMap[sensor.nameIdentity!] = index;
    });

    List<List<String>> dataTable = [];
    for (SensorData data in allData) {
      List<String> row = [];
      row.add(data.id?.toString() ?? '--');
      String time = data.timestamp != null
          ? DateFormat('yyyy-MM-dd kk:mm:ss').format(data.timestamp!)
          : '--';
      row.add(time);
      if (data.sensorNameIdentity == null &&
          sensorDataMap[data.sensorNameIdentity!] == null) {
        row.addAll(List.filled(sensors!.length, '--'));
        continue;
      }
      for (int i = 0; i < sensors!.length; i++) {
        if (i == sensorDataMap[data.sensorNameIdentity!]!) {
          row.add(data.pressure.toString());
        } else {
          row.add('--');
        }
      }
      dataTable.add(row);
    }

    return dataTable;
  }

  Future<void> generateExcelFile() async {
    emit(SensorsDataExportLoading());
    final List<int> excel = await compute<List<List<String>>, List<int>>(
      createExcel,
      _readyToExportTable,
    );
    emit(
      SensorsDataExportExcelLoaded(
          excel: excel, fileName: '$_exportFileName.xlsx'),
    );
  }

  Future<void> syncData() async {}

  List<int> createExcel(List<List<String>> dataTable) {
    final Workbook workbook = Workbook();

    final Worksheet sheet = workbook.worksheets[0];
    for (int rowIndex = 0; rowIndex < dataTable.length; rowIndex++) {
      final List<String> rowData = dataTable[rowIndex];
      for (int colIndex = 0; colIndex < rowData.length; colIndex++) {
        sheet
            .getRangeByIndex(rowIndex + 1, colIndex + 1)
            .setText(rowData[colIndex]);
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    // Call the saveFile function to save the Excel file
    final List<int> excel = Uint8List.fromList(bytes);
    return excel;
  }

  void generateCsvFile() async {
    emit(SensorsDataExportLoading());
    final String csvString = await compute<List<List<String>>, String>(
      (table) {
        return const ListToCsvConverter().convert(table);
      },
      _readyToExportTable,
    );
    emit(
      SensorsDataExportCSVLoaded(
        csvString: csvString,
        fileName: '$_exportFileName.csv',
        dataHeader: _dataHeader,
        dataTable: _dataTable,
      ),
    );
  }
}
