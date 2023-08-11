import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/config.dart';
import 'package:water_pressure_iot/flavor.dart';
import 'package:water_pressure_iot/models/project.dart';
import 'package:water_pressure_iot/repository/register_repository.dart';

part 'register_project_state.dart';

class RegisterProjectCubit extends Cubit<RegisterProjectState> {
  final RegisterRepository _repository = RegisterRepository();
  late Project project;

  RegisterProjectCubit() : super(RegisterProjectInitial()) {
    if (Config.appFlavor == Flavor.PRODUCTION) {
      project = Project();
    }
    project = Project(
      name: 'KST-WATER_PRESSURE-NBIOT',
      description: 'KST-WATER_PRESSURE-NBIOT',
      applicationField: 'Others',
      projectCode: '27483',
      projectKey: 'PK1BWRZ0KAMWBUTC5F',
    );
  }

  Future<void> getProject() async {
    emit(RegisterProjectLoading());
    try {
      project = await _repository.getProject();
      if (project.id == null) throw Exception('註冊失敗，請稍後再試');
      emit(RegisterProjectSuccess(project.id!));
    } catch (e) {
      emit(RegisterProjectFailure(e.toString()));
    } finally {
      emit(RegisterProjectLoaded());
    }
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
