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
  DateTime? minTimestamp;

  @observable
  DateTime? maxTimestamp;

  @observable
  List<DateTime>? minuteTimestamps;

  @observable
  List<List<String>> dataTable = [];

  final Duration timeInterval;

  SensorsDataTableCubit(
    this.sensors,
    this.timeInterval,
  ) : super(SensorsDataTableInitial()) {
    emit(SensorsDataTableLoading());
    // 延遲計算到下一帧後再進行
    Future.delayed(
      Duration.zero,
      () {
        // 計算相關邏輯
        List<SensorData> allData = _flatAllSensorData(sensors!);
        (DateTime? minTimestamp, DateTime? maxTimestamp)? minmax;
        minmax = _findMinMaxDate(allData);
        minTimestamp = minmax?.$1;
        maxTimestamp = minmax?.$2;
        minuteTimestamps = _findTimeIntervalBetweenMinMaxTimestamp();
        dataTable = _generateDataTable();
        // 發送狀態更新
        emit(
          SensorsDataTableLoaded(
            sensors: sensors!,
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
  (DateTime?, DateTime?)? _findMinMaxDate(List<SensorData> allData) {
    // 找出所有sensorData的最小和最大timestamp
    if (allData.isNotEmpty) {
      List<SensorData> sortedData = List.from(allData)
        ..sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
      return (sortedData.first.timestamp, sortedData.last.timestamp);
    }
    return null;
  }

  @computed
  List<DateTime> _findTimeIntervalBetweenMinMaxTimestamp() {
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

  // Helper function: 取得指定sensor在指定時間點的pressure值
  String _getPressureValueAtTimestamp(Sensor sensor, DateTime timestamp) {
    var data = sensor.sensorData?.where((data) {
      // 在指定時間區間內尋找timestamp符合的data
      DateTime nextTimestamp = timestamp.add(timeInterval);
      return data.timestamp!.isAfter(timestamp) &&
          data.timestamp!.isBefore(nextTimestamp);
    }).toList();

    return data != null && data.isNotEmpty ? data[0].pressure.toString() : '--';
  }

  @computed
  List<List<String>> _generateDataTable() {
    if (sensors == null || sensors!.isEmpty) {
      return [];
    }
    if (minuteTimestamps == null || minuteTimestamps!.isEmpty) {
      return [];
    }
    return [
      for (var timestamp in minuteTimestamps!)
        [
          '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}',
          for (var sensor in sensors!)
            _getPressureValueAtTimestamp(sensor, timestamp),
        ],
    ];
  }
}
