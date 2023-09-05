import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/models/sensor_data.dart';
import 'package:water_pressure_iot/repository/sensor_repository.dart';
import 'package:water_pressure_iot/utils/date_helper.dart';

part 'sensors_data_table_state.dart';

class SensorsDataTableCubit extends Cubit<SensorsDataTableState> {
  final SensorRepository _sensorRepository = SensorRepository();
  DateTime? _lastUpdated;

  List<Sensor>? sensors = [];

  Map<String, List<String>> _dataTimeSection = {};

  List<List<String>> _dataTable = [];

  List<String> get _dataHeader {
    if (sensors == null || sensors!.isEmpty) {
      return [];
    }
    return [
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

  List<List<String>> _generateDataTable(List<SensorData> dataList) {
    if (sensors == null || sensors!.isEmpty) {
      return [];
    }
    Map<String, int> sensorDataMap = {};
    List<List<String>> dataTable = [];

    sensors?.asMap().forEach((index, sensor) {
      sensorDataMap[sensor.nameIdentity!] = index;
    });
    for (var data in dataList) {
      String time = data.timestamp != null
          ? DateFormat('MM-dd HH:mm:s').format(data.timestamp!)
          : '--';
      if (_dataTimeSection.containsKey(time) == false) {
        _dataTimeSection[time] = List.filled(sensors!.length, '--');
        _lastUpdated = data.timestamp;
      }

      // 判斷 pressure 要加在哪一個欄位
      for (int i = 0; i < sensors!.length; i++) {
        if (i == sensorDataMap[data.sensorNameIdentity!]!) {
          _dataTimeSection[time]?[i] = data.pressure.toString();
        }
      }
    }

    // 由時間近到遠排序
    _dataTimeSection = Map.fromEntries(
      _dataTimeSection.entries.toList()
        ..sort((e1, e2) {
          return e2.key.compareTo(e1.key);
        }),
    );

    // 將 Map 轉成 List， key 為時間，value 為壓力值
    dataTable = _dataTimeSection.entries.map((e) {
      return [
        e.key,
        ...e.value,
      ];
    }).toList();

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

  Future<void> syncData() async {
    emit(
      SensorsDataTablePolling(
        dataHeader: _dataHeader,
        dataTable: _dataTable,
      ),
    );
    try {
      List<Sensor> results = await _sensorRepository.getLatestFromNBIOT(
        _lastUpdated ?? DateTime.now(),
      );
      if (results.isEmpty) {
        throw Exception('沒有更新的數據');
      }
      for (Sensor s in results) {
        int index = sensors!.indexWhere((element) => element.id == s.id);
        if (index != -1 && s.sensorData != null) {
          sensors![index].sensorData?.add(s.sensorData!.first);
        }
      }
      List<SensorData> allData = _flatAllSensorData(results);
      _dataTable = await compute<List<SensorData>, List<List<String>>>(
        _generateDataTable,
        allData,
      );
    } on Exception catch (e) {
      emit(SensorsDataTableError(message: e.toString()));
    } finally {
      print(
        'lastUpdated: ${_lastUpdated?.toIso8601String()}, allData: ${_dataTable.length}',
      );
      emit(
        SensorsDataTablePollingUpdated(
          dataHeader: _dataHeader,
          dataTable: _dataTable,
          lastUpdated:
              _lastUpdated != null ? _lastUpdated!.toIso8601String() : '',
        ),
      );
    }
  }

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
