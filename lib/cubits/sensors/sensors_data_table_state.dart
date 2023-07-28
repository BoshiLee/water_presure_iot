part of 'sensors_data_table_cubit.dart';

abstract class SensorsDataTableState extends Equatable {
  final List<String>? dataHeader;
  final List<List<String>>? dataTable;
  const SensorsDataTableState({this.dataHeader, this.dataTable});
}

class SensorsDataTableInitial extends SensorsDataTableState {
  const SensorsDataTableInitial() : super();

  @override
  List<Object> get props => [];
}

class SensorsDataTableLoading extends SensorsDataTableState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class SensorsDataExportLoading extends SensorsDataTableState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class SensorsDataExportCSVLoaded extends SensorsDataTableState {
  final String csvString;
  final String fileName;

  const SensorsDataExportCSVLoaded({
    required this.csvString,
    required this.fileName,
    super.dataHeader,
    super.dataTable,
  }) : super();

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class SensorsDataExportExcelLoaded extends SensorsDataTableState {
  final List<int> excel;
  final String fileName;

  const SensorsDataExportExcelLoaded({
    required this.excel,
    required this.fileName,
    super.dataHeader,
    super.dataTable,
  }) : super();

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class SensorsDataTableError extends SensorsDataTableState {
  final String message;

  const SensorsDataTableError({
    required this.message,
  }) : super();

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class SensorsDataTableLoaded extends SensorsDataTableState {
  @override
  final List<String> dataHeader;
  @override
  final List<List<String>> dataTable;

  const SensorsDataTableLoaded({
    required this.dataHeader,
    required this.dataTable,
  }) : super();

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}
