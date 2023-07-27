import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/models/account.dart';
import 'package:water_pressure_iot/models/login_auth.dart';
import 'package:water_pressure_iot/repository/login_repository.dart';
import 'package:water_pressure_iot/repository/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository _userRepository = UserRepository.shared;
  final LoginRepository _loginRepository = LoginRepository();

  LoginCubit() : super(LoginInitial()) {
    if (_userRepository.email != null && _userRepository.email!.isNotEmpty) {
      auth = LoginAuth(
        email: _userRepository.email,
        password: '',
      );
      emit(LoginEmailChanged(auth.email!));
    } else {
      auth = LoginAuth();
    }
  }

  late LoginAuth auth;

  set rememberMail(bool rememberMe) {
    _userRepository.rememberMe = rememberMe;
  }

  bool get rememberMail {
    return _userRepository.rememberMe;
  }

  void login() async {
    emit(LoginLoading());
    try {
      auth.validate();
      emit(LoginLoading());
      final account = await _loginRepository.login(auth);
      if (account == null) {
        emit(const LoginError('無法取得帳號資訊'));
        return;
      }
      if (rememberMail) {
        _userRepository.email = auth.email;
      } else {
        _userRepository.email = null;
      }
      _userRepository.jwt = account.token;
      emit(LoginSuccess(account));
    } catch (e) {
      emit(LoginError(e.toString()));
    } finally {
      emit(LoginLoaded());
    }
  }
}
