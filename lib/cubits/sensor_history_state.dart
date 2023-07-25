part of 'sensor_history_cubit.dart';

abstract class SensorHistoryState extends Equatable {
  const SensorHistoryState();
}

class SensorHistoryInitial extends SensorHistoryState {
  @override
  List<Object> get props => [];
}

class SensorHistoryDidExport extends SensorHistoryState {
  @override
  List<Object> get props => [];
}
