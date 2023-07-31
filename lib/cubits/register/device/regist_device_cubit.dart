import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'regist_device_state.dart';

class RegistDeviceCubit extends Cubit<RegistDeviceState> {
  RegistDeviceCubit() : super(RegistDeviceInitial());
}
