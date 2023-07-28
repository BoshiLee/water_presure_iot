import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/models/sensor_data.dart';

part 'sensors_data_table_state.dart';

class SensorsDataTableCubit extends Cubit<SensorsDataTableState> {
  List<Sensor>? sensors = [];

  List<List<String>> dataTable = [];

  List<String> get dataHeader {
    if (sensors == null || sensors!.isEmpty) {
      return [];
    }
    return [
      'UID',
      'Time',
      for (var sensor in sensors!) '${sensor.nameIdentity}',
    ];
  }

  final Duration timeInterval;

  SensorsDataTableCubit(
    this.sensors,
    this.timeInterval,
  ) : super(SensorsDataTableInitial()) {
    initializeData();
  }

  Future<void> initializeData() async {
    emit(SensorsDataTableLoading());
    List<SensorData> allData = await compute<List<Sensor>, List<SensorData>>(
      _flatAllSensorData,
      sensors!,
    );
    dataTable = await compute<List<SensorData>, List<List<String>>>(
      _generateDataTable,
      allData,
    );
    emit(
      SensorsDataTableLoaded(
        dataHeader: dataHeader,
        dataTable: dataTable,
      ),
    );
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
      row.add(data.timestamp!.toIso8601String());
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

  void generateCsvFile() async {
    emit(SensorsDataExportLoading());
    final String csvString = await compute<List<List<String>>, String>(
      createCSVString,
      dataTable,
    );
  }

  String createCSVString(List<List<String>> dataTable) {
    List<List<dynamic>> rows = dataTable
        .map((row) => row.map((cell) => cell as dynamic).toList())
        .toList();
    List<String> headers = dataHeader;
    return const ListToCsvConverter().convert(rows);
  }
}
