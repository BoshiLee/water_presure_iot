import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/repository/sensor_repository.dart';

part 'sensors_state.dart';

class SensorsCubit extends Cubit<SensorsState> {
  final SensorRepository _repository = SensorRepository();
  List<Sensor> sensors = [];

  SensorsCubit() : super(const SensorsInitial()) {
    fetchSensors();
  }

  void refresh() => fetchSensors(refresh: true);

  Future<void> fetchSensors({bool refresh = false}) async {
    if (state is SensorsLoading) return;
    emit(const SensorsLoading(message: '感測器資料讀取中'));
    try {
      if (refresh) {
        sensors = [];
      } else {
        // 先更新 DB 資料
        // await _repository.importSensorDataFromCHT();
      }
      // 取得感測器資料
      sensors = await _repository.fetchSensors();
      if (sensors.isEmpty) {
        throw Exception('無法取得感測器資訊');
      }
      // 只保留有sensorData的sensor
      sensors = await compute<List<Sensor>, List<Sensor>>(
        findValidSensors,
        sensors,
      );
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

  List<Sensor> findValidSensors(List<Sensor> sensors) => sensors
      .where(
        (sensor) => sensor.sensorData != null && sensor.sensorData!.isNotEmpty,
      )
      .toList();
}
