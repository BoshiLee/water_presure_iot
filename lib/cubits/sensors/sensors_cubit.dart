import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/models/sensor_data.dart';
import 'package:water_pressure_iot/repository/sensor_repository.dart';

part 'sensors_state.dart';

class SensorsCubit extends Cubit<SensorsState> {
  final SensorRepository _repository = SensorRepository();
  List<Sensor> sensors = [];
  List<SensorData> allData = [];
  List<DateTime>? minuteTimestamps;
  Duration timeInterval;
  DateTime? minTimestamp;
  DateTime? maxTimestamp;
  SensorsCubit({
    this.timeInterval = const Duration(minutes: 1),
  }) : super(SensorsInitial()) {
    fetchSensors();
  }

  void refresh() => fetchSensors();

  Future<void> fetchSensors() async {
    emit(const SensorsLoading());
    try {
      sensors = await _repository.fetchSensors();
      if (sensors.isEmpty) {
        throw Exception('無法取得感測器資訊');
      }
      sensors = findValidSensors(sensors); // 只保留有sensorData的sensor
    } catch (e) {
      emit(SensorsError(e.toString()));
    } finally {
      emit(
        SensorsLoaded(
          sensors,
        ),
      );
    }
  }

  List<Sensor> findValidSensors(List<Sensor> sensors) => sensors
      .where(
        (sensor) => sensor.sensorData != null && sensor.sensorData!.isNotEmpty,
      )
      .toList();
}
