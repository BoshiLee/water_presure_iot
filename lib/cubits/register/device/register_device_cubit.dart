import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/api/api_response.dart';
import 'package:water_pressure_iot/models/device.dart';
import 'package:water_pressure_iot/repository/register_repository.dart';
import 'package:water_pressure_iot/repository/sensor_repository.dart';
import 'package:water_pressure_iot/repository/user_repository.dart';

part 'register_device_state.dart';

class RegisterDeviceCubit extends Cubit<RegisterDeviceState> {
  final int projectId;
  final RegisterRepository _repository = RegisterRepository();
  final SensorRepository _sensorRepository = SensorRepository();
  List<Device> devices = [];

  RegisterDeviceCubit({
    required this.projectId,
    required this.devices,
  }) : super(RegisterDeviceInitial()) {}

  Future<void> registerDevices() async {
    if (UserRepository.shared.registerProgress == null) {
      emit(
        const RegisterDeviceSuccess(),
      );
      return;
    }
    emit(const RegisterDeviceLoading());
    try {
      final List<Device> result = await _repository.registerDevices(
        devices: devices,
        projectId: projectId,
      );
      devices = result;
      UserRepository.shared.registerProgress = null; // reset register progress
      emit(
        const RegisterDeviceSuccess(),
      );
    } catch (e) {
      emit(RegisterDeviceFailure(e.toString()));
    } finally {
      emit(RegisterDeviceLoaded());
    }
  }

  Future portingSensor() async {
    try {
      emit(const RegisterDeviceLoading(message: '匯入感測器中...'));
      final ApiResponse sensorResult = await _repository.importSensorsFromCHT();
      emit(
        RegisterDeviceSImportSensorsSuccess(
          message: sensorResult.message ?? '匯入感測器成功',
        ),
      );
      emit(const RegisterDeviceLoading(message: '匯入感測器資料中...'));
      final ApiResponse sensorsDataResult =
          await _sensorRepository.importSensorDataFromCHT(
        startTime: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          1,
        ),
      );
      emit(
        RegisterDeviceSImportSensorsDataSuccess(
          message: sensorsDataResult.message ?? '匯入感測器資料成功',
        ),
      );
    } catch (e) {
      emit(RegisterDeviceFailure(e.toString()));
    } finally {
      emit(RegisterDeviceLoaded());
    }
  }
}
