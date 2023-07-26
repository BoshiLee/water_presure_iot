import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/repository/sensor_repository.dart';

part 'sensors_state.dart';

class SensorsCubit extends Cubit<SensorsState> {
  final SensorRepository _repository = SensorRepository();
  List<Sensor> sensors = [];
  SensorsCubit() : super(SensorsInitial()) {
    fetchSensors();
  }

  void refresh() => fetchSensors();

  Future<void> fetchSensors() async {
    emit(SensorsLoading());
    try {
      sensors = await _repository.fetchSensors();
      emit(SensorsLoaded(sensors));
    } catch (e) {
      emit(SensorsError(e.toString()));
    }
  }
}
