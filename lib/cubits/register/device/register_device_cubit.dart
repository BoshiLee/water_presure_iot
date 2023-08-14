import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/api/api_response.dart';
import 'package:water_pressure_iot/config.dart';
import 'package:water_pressure_iot/flavor.dart';
import 'package:water_pressure_iot/models/device.dart';
import 'package:water_pressure_iot/repository/register_repository.dart';
import 'package:water_pressure_iot/repository/user_repository.dart';

part 'register_device_state.dart';

class RegisterDeviceCubit extends Cubit<RegisterDeviceState> {
  final int projectId;
  final RegisterRepository _repository = RegisterRepository();
  List<Device> devices = [];

  RegisterDeviceCubit({
    required this.projectId,
    required this.devices,
  }) : super(RegisterDeviceInitial()) {
    if (Config.appFlavor == Flavor.PRODUCTION) return;
    final List<Device> fakeDevices = [
      devices[0]
          .copyWith(name: '3103112070100001', deviceKey: 'DK0EFSHX4CWG179RET'),
      devices[1]
          .copyWith(name: '3103112070100002', deviceKey: 'DKA2F4SZ1CGZ4CX0FK'),
      devices[2]
          .copyWith(name: '3103112070100003', deviceKey: 'DKCHY1UZBTKCCM5EP7'),
    ];
    devices = fakeDevices;
  }

  Future<void> registerDevices() async {
    if (UserRepository.shared.registerProgress == null) {
      emit(
        const RegisterDeviceSuccess(),
      );
    }
    emit(RegisterDeviceLoading());
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

  Future portSensorData() async {
    emit(RegisterDeviceLoading());
    try {
      final ApiResponse result = await _repository.importSensorsFromCHT();
      emit(
        const RegisterDeviceSImportSensorsSuccess(),
      );
    } catch (e) {
      emit(RegisterDeviceFailure(e.toString()));
    } finally {
      emit(RegisterDeviceLoaded());
    }
  }
}
