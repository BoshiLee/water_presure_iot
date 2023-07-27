part of 'sensors_data_table_cubit.dart';

abstract class SensorsDataTableState extends Equatable {
  const SensorsDataTableState();
}

class SensorsDataTableInitial extends SensorsDataTableState {
  @override
  List<Object> get props => [];
}

class SensorsDataTableLoading extends SensorsDataTableState {
  @override
  List<Object> get props => [];
}

class SensorsDataTableLoaded extends SensorsDataTableState {
  final List<String> dataHeader;
  final List<List<String>> dataTable;

  const SensorsDataTableLoaded({
    required this.dataHeader,
    required this.dataTable,
  }) : super();

  @override
  List<Object> get props => [];
}
