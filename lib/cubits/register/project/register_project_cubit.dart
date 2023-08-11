import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/config.dart';
import 'package:water_pressure_iot/flavor.dart';
import 'package:water_pressure_iot/models/project.dart';
import 'package:water_pressure_iot/models/register_progress.dart';
import 'package:water_pressure_iot/repository/register_repository.dart';
import 'package:water_pressure_iot/repository/user_repository.dart';

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

  Future<void> registerProject() async {
    emit(
      const RegisterProjectLoading(message: '註冊專案中...'),
    );
    try {
      Project project = await _repository.registerProject(this.project);
      if (project.id == null) throw Exception('註冊失敗，請稍後再試');
      this.project = project;
      emit(RegisterProjectSuccess(project.id!));
      UserRepository.shared.registerProgress =
          RegisterProgress.registeredProject;
    } catch (e) {
      UserRepository.shared.registerProgress = null;
      emit(RegisterProjectFailure(e.toString()));
    } finally {
      emit(RegisterProjectLoaded());
    }
  }
}
