part of 'register_device_cubit.dart';

abstract class RegisterDeviceState extends Equatable {
  const RegisterDeviceState();
}

class RegisterDeviceInitial extends RegisterDeviceState {
  @override
  List<Object> get props => [];
}

class RegisterDeviceLoading extends RegisterDeviceState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class RegisterDeviceLoaded extends RegisterDeviceState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class RegisterDeviceSuccess extends RegisterDeviceState {
  const RegisterDeviceSuccess();

  @override
  List<Object?> get props => [DateTime.now().toIso8601String()];
}

class RegisterDeviceSImportSensorsSuccess extends RegisterDeviceState {
  const RegisterDeviceSImportSensorsSuccess();

  @override
  List<Object?> get props => [DateTime.now().toIso8601String()];
}

class RegisterDeviceFailure extends RegisterDeviceState {
  final String error;

  const RegisterDeviceFailure(this.error);

  @override
  List<Object?> get props => [error];
}
