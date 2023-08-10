import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/models/project.dart';
import 'package:water_pressure_iot/repository/register_repository.dart';

part 'register_project_state.dart';

class RegisterProjectCubit extends Cubit<RegisterProjectState> {
  final RegisterRepository _repository = RegisterRepository();
  late Project project;

  RegisterProjectCubit() : super(RegisterProjectInitial()) {
    project = Project();
  }

  Future<void> registerProject() async {
    emit(RegisterProjectLoading());
    try {
      project = await _repository.registerProject(project);
      if (project.id == null) throw Exception('註冊失敗，請稍後再試');
      emit(RegisterProjectSuccess(project.id!));
    } catch (e) {
      emit(RegisterProjectFailure(e.toString()));
    } finally {
      emit(RegisterProjectLoaded());
    }
  }
}
