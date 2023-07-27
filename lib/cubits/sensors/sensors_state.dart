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

  const SensorsLoaded(
    this.sensors,
  ) : super(sensors);
}

class SensorsError extends SensorsState {
  final String message;
  const SensorsError(this.message) : super(null);
}
