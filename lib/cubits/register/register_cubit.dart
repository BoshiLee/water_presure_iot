import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/config.dart';
import 'package:water_pressure_iot/flavor.dart';
import 'package:water_pressure_iot/models/account.dart';
import 'package:water_pressure_iot/models/login_auth.dart';
import 'package:water_pressure_iot/repository/register_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository _repository = RegisterRepository();
  late RegisterAuth auth;
  RegisterCubit() : super(RegisterInitial()) {
    if (Config.appFlavor == Flavor.PRODUCTION) {
      auth = RegisterAuth();
    }
    auth = RegisterAuth(
      name: 'test',
      email: 'test@dev.com',
      password: '123456',
      passwordConfirmation: '123456',
    );
  }

  void validAuthAndPushToNextPage() {
    try {
      auth.validate();
      emit(RegisterValid());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    } finally {
      emit(RegisterLoaded());
    }
  }

  Future<void> register() async {
    emit(RegisterLoading());
    try {
      final account = await _repository.registerAccount(auth);
      if (account == null) throw Exception('註冊失敗，請稍後再試');
      emit(RegisterSuccess(account));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    } finally {
      emit(RegisterLoaded());
    }
  }
}
