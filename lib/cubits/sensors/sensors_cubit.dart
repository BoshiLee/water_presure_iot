import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/models/sensor_data.dart';
import 'package:water_pressure_iot/repository/sensor_repository.dart';

part 'sensors_state.dart';

class SensorsCubit extends Cubit<SensorsState> {
  final SensorRepository _repository = SensorRepository();
  List<Sensor> sensors = [];

  SensorsCubit() : super(const SensorsInitial()) {
    fetchSensors();
  }

  void refresh() => fetchSensors();

  Future<void> fetchSensors() async {
    if (state is SensorsLoading) return;
    emit(const SensorsLoading(message: '感測器資料讀取中'));
    try {
      sensors = await _repository.fetchSensors();
      if (sensors.isEmpty) {
        throw Exception('無法取得感測器資訊');
      }
      // 只保留有sensorData的sensor
      sensors = await compute<List<Sensor>, List<Sensor>>(
        findValidSensors,
        sensors,
      );
      // 取得最新的sensorData
      final DateTime? latest = _compareTimeStampInSensors(sensors);
      emit(
        SensorsLoaded(sensors),
      );
    } catch (e) {
      emit(SensorsError(e.toString()));
    } finally {
      emit(
        SensorsLoaded(sensors),
      );
    }
  }

  DateTime? _compareTimeStampInSensors(List<Sensor> sensors) {
    final DateTime? latest = sensors
        .map((sensor) => sensor.sensorData?.first.timestamp)
        .reduce((value, element) => value!.isAfter(element!) ? value : element);

    return latest;
  }

  Future updateSensorsData() async {
    if (sensors.isEmpty) return;
    int index = 0;
    String message = '感測器 ${sensors[index].nameIdentity ?? ''} 資料更新中)';
    emit(SensorsLoading(message: message));
    await Future.forEach(
      sensors,
      (sensor) => updateSensorDataFromNBIOT(index++, sensor.id),
    ).then(
      (value) => index += 1,
    );
    emit(SensorsLoaded(sensors));
  }

  Future<void> updateSensorDataFromNBIOT(int index, int? sensorId) async {
    if (sensorId == null) return;
    try {
      final List<SensorData> sensorData =
          await _repository.updateFromNBIOT(sensorId);
      if (sensorData.isEmpty) {
        throw Exception('無法取得感測器資訊');
      }
      if (sensors[index].sensorData == null) {
        sensors[index].sensorData = [];
      }
      sensors[index].sensorData?.addAll(sensorData);
    } catch (e) {
      emit(SensorsError(e.toString()));
    }
  }

  List<Sensor> findValidSensors(List<Sensor> sensors) => sensors
      .where(
        (sensor) => sensor.sensorData != null && sensor.sensorData!.isNotEmpty,
      )
      .toList();
}
