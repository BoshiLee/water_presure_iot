import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/constants/test_accounts.dart';
import 'package:water_pressure_iot/models/account.dart';
import 'package:water_pressure_iot/models/login_auth.dart';
import 'package:water_pressure_iot/models/project.dart';
import 'package:water_pressure_iot/models/register_progress.dart';
import 'package:water_pressure_iot/repository/login_repository.dart';
import 'package:water_pressure_iot/repository/register_repository.dart';
import 'package:water_pressure_iot/repository/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository _userRepository = UserRepository.shared;
  final LoginRepository _loginRepository = LoginRepository();
  final RegisterRepository _registerRepository = RegisterRepository();
  Project? project;

  LoginCubit() : super(LoginInitial()) {
    if (_userRepository.email != null && _userRepository.email!.isNotEmpty) {
      auth = LoginAuth(
        email: _userRepository.email,
        password: '',
      );
      emit(LoginEmailChanged(auth.email!));
    } else {
      auth = LoginAuth(
        email: email,
        password: password,
      );
    }
  }

  late LoginAuth auth;

  set rememberMail(bool rememberMe) {
    _userRepository.rememberMe = rememberMe;
  }

  bool get rememberMail {
    return _userRepository.rememberMe;
  }

  void checkRegisterProgress() async {
    RegisterProgress? pg = _userRepository.registerProgress;
    if (pg == null || _userRepository.jwt == null) {
      emit(const LoginResumeRegisterProgress(null));
      return;
    }
    if (pg != RegisterProgress.registeredProject) {
      emit(LoginResumeRegisterProgress(pg));
      return;
    }
    try {
      // 因為已註冊完專案的話應該可進入到註冊裝置，這時應該先預取得裝置
      emit(LoginLoading());
      project = await _registerRepository.getPreferProject();
    } catch (e) {
      emit(LoginError(e.toString()));
    } finally {
      emit(LoginLoaded());
    }
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
