part of 'sensors_cubit.dart';

@immutable
abstract class SensorsState {
  final List<Sensor>? sensors;
  const SensorsState(this.sensors);
}

class SensorsInitial extends SensorsState {
  const SensorsInitial() : super(null);
}

class SensorsLoading extends SensorsState {
  const SensorsLoading() : super(null);
}

class SensorsLoaded extends SensorsState {
  @override
  final List<Sensor> sensors;
  final Duration timeInterval; // 時間間隔
  final DateTime? minTimestamp; // 最早的timestamp
  final DateTime? maxTimestamp; // 最晚的timestamp
  final List<DateTime>? minuteTimestamps;
  const SensorsLoaded(
    this.sensors,
    this.timeInterval,
    this.minTimestamp,
    this.maxTimestamp,
    this.minuteTimestamps,
  ) : super(sensors);
}

class SensorsError extends SensorsState {
  final String message;
  const SensorsError(this.message) : super(null);
}
