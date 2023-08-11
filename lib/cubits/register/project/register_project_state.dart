part of 'register_project_cubit.dart';

abstract class RegisterProjectState extends Equatable {
  const RegisterProjectState();
}

class RegisterProjectInitial extends RegisterProjectState {
  @override
  List<Object> get props => [];
}

class RegisterProjectLoading extends RegisterProjectState {
  final String message;

  const RegisterProjectLoading({this.message = 'Loading...'});

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class RegisterProjectLoaded extends RegisterProjectState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class RegisterProjectSuccess extends RegisterProjectState {
  final int projectId;

  const RegisterProjectSuccess(this.projectId);

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class RegisterProjectFailure extends RegisterProjectState {
  final String error;

  const RegisterProjectFailure(this.error);

  @override
  List<Object?> get props => [error];
}
