import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/models/device.dart';
import 'package:water_pressure_iot/repository/register_repository.dart';

part 'register_device_state.dart';

class RegisterDeviceCubit extends Cubit<RegisterDeviceState> {
  final int projectId;
  final List<Device> chtDevices;
  final RegisterRepository _repository = RegisterRepository();
  List<Device> devices = [];

  RegisterDeviceCubit({
    required this.projectId,
    required this.chtDevices,
  }) : super(RegisterDeviceInitial());

  Future<void> registerDevices() async {
    emit(RegisterDeviceLoading());
    try {
      final List<Device> result = await _repository.registerDevices(
        devices: devices,
        projectId: projectId,
      );
      devices = result;
      emit(
        RegisterDeviceSuccess(
          devices: devices,
        ),
      );
    } catch (e) {
      emit(RegisterDeviceFailure(e.toString()));
    } finally {
      emit(RegisterDeviceLoaded());
    }
  }
}
