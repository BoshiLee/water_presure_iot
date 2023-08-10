part of 'register_device_cubit.dart';

abstract class RegisterDeviceTutorState extends Equatable {
  const RegisterDeviceTutorState();
}

class RegisterDeviceTutorInitial extends RegisterDeviceTutorState {
  @override
  List<Object> get props => [];
}

class RegisterDeviceTutorLoading extends RegisterDeviceTutorState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class RegisterDeviceTutorLoaded extends RegisterDeviceTutorState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class RegisterDeviceTutorImportSuccess extends RegisterDeviceTutorState {
  final List<Device> devices;
  final int projectId;
  const RegisterDeviceTutorImportSuccess({
    required this.projectId,
    required this.devices,
  });

  @override
  List<Object?> get props => [DateTime.now().toIso8601String()];
}

class RegisterDeviceTutorFailure extends RegisterDeviceTutorState {
  final String error;

  const RegisterDeviceTutorFailure(this.error);

  @override
  List<Object?> get props => [error];
}
