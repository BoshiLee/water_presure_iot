import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/config.dart';
import 'package:water_pressure_iot/constants/test_accounts.dart';
import 'package:water_pressure_iot/flavor.dart';
import 'package:water_pressure_iot/models/account.dart';
import 'package:water_pressure_iot/models/login_auth.dart';
import 'package:water_pressure_iot/models/register_progress.dart';
import 'package:water_pressure_iot/repository/register_repository.dart';
import 'package:water_pressure_iot/repository/user_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository _repository = RegisterRepository();
  final UserRepository _userRepository = UserRepository.shared;
  late RegisterAuth auth;
  RegisterCubit() : super(RegisterInitial()) {
    if (Config.appFlavor == Flavor.PRODUCTION) {
      auth = RegisterAuth();
    }
    auth = RegisterAuth(
      name: 'Boshi',
      email: email,
      password: password,
      passwordConfirmation: password,
    );
  }

  Future<void> register() async {
    emit(RegisterLoading());
    try {
      final account = await _repository.registerAccount(auth);
      if (account == null) throw Exception('註冊失敗，請稍後再試');
      if (account.token != null) {
        _userRepository.jwt = account.token;
        _userRepository.email = account.email;
        _userRepository.registerProgress = RegisterProgress.registeredUser;
      }
      emit(RegisterSuccess(account));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    } finally {
      emit(RegisterLoaded());
    }
  }
}
