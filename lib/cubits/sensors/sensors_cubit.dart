import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/repository/sensor_repository.dart';

part 'sensors_state.dart';

class SensorsCubit extends Cubit<SensorsState> {
  final SensorRepository _repository = SensorRepository();
  List<Sensor> _sensors = [];

  SensorsCubit() : super(const SensorsInitial()) {
    fetchSensors();
  }

  void refresh() => fetchSensors();

  Future<void> fetchSensors() async {
    emit(const SensorsLoading());
    try {
      _sensors = await _repository.fetchSensors();
      if (_sensors.isEmpty) {
        throw Exception('無法取得感測器資訊');
      }
      // 只保留有sensorData的sensor
      _sensors = await compute<List<Sensor>, List<Sensor>>(
        findValidSensors,
        _sensors,
      );
    } catch (e) {
      emit(SensorsError(e.toString()));
    } finally {
      emit(
        SensorsLoaded(_sensors),
      );
    }
  }

  List<Sensor> findValidSensors(List<Sensor> sensors) => sensors
      .where(
        (sensor) => sensor.sensorData != null && sensor.sensorData!.isNotEmpty,
      )
      .toList();
}
