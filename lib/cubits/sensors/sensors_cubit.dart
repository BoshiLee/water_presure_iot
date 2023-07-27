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
      getAllData();
      findMinMaxDate(allData);
      minuteTimestamps = findTimeIntervalBetweenMinMaxTimestamp();
    } catch (e) {
      emit(SensorsError(e.toString()));
    } finally {
      emit(
        SensorsLoaded(
          sensors,
          timeInterval,
          minTimestamp,
          maxTimestamp,
          minuteTimestamps,
        ),
      );
    }
  }

  List<Sensor> findValidSensors(List<Sensor> sensors) => sensors
      .where(
        (sensor) => sensor.sensorData != null && sensor.sensorData!.isNotEmpty,
      )
      .toList();

  void getAllData() {
    for (var sensor in sensors) {
      allData.addAll(sensor.sensorData ?? []);
    }
  }

  void findMinMaxDate(List<SensorData> allData) {
    // 找出所有sensorData的最小和最大timestamp
    if (allData.isNotEmpty) {
      List<SensorData> sortedData = List.from(allData)
        ..sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
      minTimestamp = sortedData.first.timestamp;
      maxTimestamp = sortedData.last.timestamp;
    }
  }

  List<DateTime> findTimeIntervalBetweenMinMaxTimestamp() {
    // 計算每一分鐘的時間點
    List<DateTime> minuteTimestamps = [];
    if (minTimestamp != null && maxTimestamp != null) {
      DateTime currentMinute = minTimestamp!.subtract(
        Duration(seconds: minTimestamp!.second),
      );
      while (currentMinute.isBefore(maxTimestamp!)) {
        minuteTimestamps.add(currentMinute);
        currentMinute = currentMinute.add(timeInterval);
      }
    }
    return minuteTimestamps;
  }
}
