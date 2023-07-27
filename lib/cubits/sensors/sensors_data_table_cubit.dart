import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobx/mobx.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/models/sensor_data.dart';

part 'sensors_data_table_state.dart';

class SensorsDataTableCubit extends Cubit<SensorsDataTableState> {
  @observable
  List<Sensor>? sensors = [];

  @observable
  List<List<String>> dataTable = [];

  List<String> get dataHeader {
    if (sensors == null || sensors!.isEmpty) {
      return [];
    }
    return ['Time', for (var sensor in sensors!) '${sensor.nameIdentity}'];
  }

  final Duration timeInterval;

  SensorsDataTableCubit(
    this.sensors,
    this.timeInterval,
  ) : super(SensorsDataTableInitial()) {}

  @action
  Future<void> initializeData() async {
    emit(SensorsDataTableLoading());

    await Future.delayed(
      Duration.zero,
      () {
        List<SensorData> allData = _flatAllSensorData(sensors!);
        dataTable = _generateDataTable(allData);
        emit(
          SensorsDataTableLoaded(
            dataHeader: dataHeader,
            dataTable: dataTable,
          ),
        );
      },
    );
  }

  @computed
  List<SensorData> _flatAllSensorData(List<Sensor> sensors) {
    List<SensorData> flatData = [];
    for (var sensor in sensors) {
      flatData.addAll(sensor.sensorData ?? []);
    }
    return flatData;
  }

  @computed
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
        dataTable.add(row);
      }
    }

    return dataTable;
  }
}
