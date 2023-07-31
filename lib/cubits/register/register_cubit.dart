import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/cubits/app/app_cubit.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AppCubit _appcubit;

  RegisterCubit(this._appcubit) : super(RegisterInitial());
}
