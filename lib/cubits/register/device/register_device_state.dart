part of 'register_device_cubit.dart';

abstract class RegisterDeviceState extends Equatable {
  const RegisterDeviceState();
}

class RegisterDeviceInitial extends RegisterDeviceState {
  @override
  List<Object> get props => [];
}

class RegisterDeviceLoading extends RegisterDeviceState {
  final String? message;

  const RegisterDeviceLoading({this.message});

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
  final String message;

  const RegisterDeviceSImportSensorsSuccess({required this.message});

  @override
  List<Object?> get props => [DateTime.now().toIso8601String()];
}

class RegisterDeviceSImportSensorsDataSuccess extends RegisterDeviceState {
  final String message;
  const RegisterDeviceSImportSensorsDataSuccess({required this.message});

  @override
  List<Object?> get props => [DateTime.now().toIso8601String()];
}

class RegisterDeviceFailure extends RegisterDeviceState {
  final String error;

  const RegisterDeviceFailure(this.error);

  @override
  List<Object?> get props => [error];
}
