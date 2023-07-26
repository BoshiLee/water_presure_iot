import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/repository/user_repository.dart';
import 'package:water_pressure_iot/utils/shared_preferences_utils.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  Future startApp() async {
    await initializeAppSetting();
    authenticator();
  }

  Future initializeAppSetting() async {
    emit(AppUninitialized());
    await SharedPreferencesUtils.getInstance();
    await Future.delayed(
      const Duration(milliseconds: 1500),
      () => emit(AppInitialized()),
    );
  }

  AppCubit() : super(AppInitial()) {}

  final UserRepository _userRepository = UserRepository.shared;

  bool rememberMe = false;

  void authenticator() async {
    if (_userRepository.hasJWT) {
      emit(AppAuthenticated());
    } else {
      emit(AppNotLogin());
    }
  }
}
