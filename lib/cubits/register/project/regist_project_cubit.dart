import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'regist_project_state.dart';

class RegistProjectCubit extends Cubit<RegistProjectState> {
  RegistProjectCubit() : super(RegistProjectInitial());
}
