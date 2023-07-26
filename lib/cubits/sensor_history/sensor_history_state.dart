part of 'sensor_history_cubit.dart';

abstract class SensorHistoryState extends Equatable {
  final String sensorName;
  const SensorHistoryState(this.sensorName);
}

class SensorHistoryInitial extends SensorHistoryState {
  const SensorHistoryInitial(super.sensorName);

  @override
  List<Object> get props => [];
}

class SensorHistoryConverted extends SensorHistoryState {
  final String csvString;

  const SensorHistoryConverted(
    super.sensorName,
    this.csvString,
  );
  @override
  List<Object> get props => [];
}

class SensorHistoryDidExport extends SensorHistoryState {
  const SensorHistoryDidExport(super.sensorName);

  @override
  List<Object> get props => [];
}
