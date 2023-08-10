import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/models/device.dart';
import 'package:water_pressure_iot/repository/register_repository.dart';

part 'register_device_tutor_state.dart';

class RegisterDeviceTutorCubit extends Cubit<RegisterDeviceTutorState> {
  final RegisterRepository _repository = RegisterRepository();
  final int projectId;
  List<Device> devices = [];

  RegisterDeviceTutorCubit({required this.projectId})
      : super(RegisterDeviceTutorInitial());

  Future<void> importDevicesFromCHT() async {
    emit(RegisterDeviceTutorLoading());
    try {
      final List<Device> result = await _repository.importDevicesFromCHT(
        projectId: projectId,
      );
      devices = result;
      emit(
        RegisterDeviceTutorImportSuccess(
          projectId: projectId,
          devices: devices,
        ),
      );
    } catch (e) {
      emit(RegisterDeviceTutorFailure(e.toString()));
    } finally {
      emit(RegisterDeviceTutorLoaded());
    }
  }
}
