import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/models/account.dart';
import 'package:water_pressure_iot/models/login_auth.dart';
import 'package:water_pressure_iot/repository/register_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository _repository = RegisterRepository();
  late RegisterAuth auth;
  RegisterCubit() : super(RegisterInitial()) {
    auth = RegisterAuth();
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
