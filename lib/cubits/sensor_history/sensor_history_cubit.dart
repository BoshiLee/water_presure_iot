import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/models/sensor_data.dart';

part 'sensor_history_state.dart';

class SensorHistoryCubit extends Cubit<SensorHistoryState> {
  final Sensor sensor;

  SensorHistoryCubit({
    required this.sensor,
  }) : super(const SensorHistoryInitial(''));

  void exportToCsv() {
    List<List<String>> csvData = [
      ['Time', 'Pressure']
    ];

    for (SensorData data in sensor.sensorData ?? []) {
      csvData.add([
        data.timestamp.toString(),
        data.pressure.toString(),
      ]);
    }

    String csvString = const ListToCsvConverter().convert(csvData);

    emit(
      SensorHistoryConverted(
        sensor.name ?? '',
        csvString,
      ),
    );
  }
}
