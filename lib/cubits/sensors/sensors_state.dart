part of 'sensors_cubit.dart';

@immutable
abstract class SensorsState {}

class SensorsInitial extends SensorsState {}

class SensorsLoading extends SensorsState {}

class SensorsLoaded extends SensorsState {
  final List<Sensor> sensors;
  SensorsLoaded(this.sensors);
}

class SensorsError extends SensorsState {
  final String message;
  SensorsError(this.message);
}
