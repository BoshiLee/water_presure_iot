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
  final String message;

  const SensorsLoading({this.message = '感測器資料讀取中'}) : super(null);
}

class SensorsLoaded extends SensorsState {
  @override
  final List<Sensor> sensors;

  const SensorsLoaded(
    this.sensors,
  ) : super(sensors);

  List<Object> get props => [DateTime.now().toIso8601String()];
}

class SensorsError extends SensorsState {
  final String message;
  const SensorsError(this.message) : super(null);
}
