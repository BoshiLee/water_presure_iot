part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class LoginEmailChanged extends LoginState {
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object> get props => [message];
}

class LoginResumeRegisterProgress extends LoginState {
  final RegisterProgress? registerProgress;

  const LoginResumeRegisterProgress(this.registerProgress);

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class LoginSuccess extends LoginState {
  final Account account;

  const LoginSuccess(this.account);

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}
