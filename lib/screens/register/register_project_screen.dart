import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/register/project/register_project_cubit.dart';
import 'package:water_pressure_iot/screens/register/wigets/title_input_field.dart';
import 'package:water_pressure_iot/screens/routing/routing_manager.dart';
import 'package:water_pressure_iot/screens/widgets/custom_loading_widget.dart';

class RegisterProjectScreen extends StatelessWidget {
  static const id = 'register_project_screen';

  const RegisterProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('註冊專案'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<RegisterProjectCubit, RegisterProjectState>(
        listener: (context, state) {
          if (state is RegisterProjectFailure) {
            BotToast.showText(text: state.error);
          }
          if (state is RegisterProjectLoading) {
            BotToast.showCustomLoading(
              toastBuilder: (_) => CustomLoadingWidget(
                message: state.message,
              ),
            );
          }
          if (state is RegisterProjectLoaded) {
            BotToast.closeAllLoading();
          }
          if (state is RegisterProjectSuccess) {
            RoutingManager.pushToRegisterDeviceTutorScreen(
              context,
              projectId: state.projectId,
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  key: const PageStorageKey('register_project_screen'),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          '請輸入專案資訊',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TitleInputField(
                        initialValue:
                            context.watch<RegisterProjectCubit>().project.name,
                        title: '輸入專案名稱',
                        hintText: 'Project Name',
                        onChanged: (value) => context
                            .read<RegisterProjectCubit>()
                            .project
                            .name = value,
                      ),
                      TitleInputField(
                        initialValue: context
                            .watch<RegisterProjectCubit>()
                            .project
                            .description,
                        title: '輸入專案描述',
                        hintText: 'Project Description',
                        onChanged: (value) => context
                            .read<RegisterProjectCubit>()
                            .project
                            .description = value,
                      ),
                      TitleInputField(
                        initialValue: context
                            .watch<RegisterProjectCubit>()
                            .project
                            .applicationField,
                        title: '輸入應用領域',
                        hintText: 'Project Application Field',
                        onChanged: (value) => context
                            .read<RegisterProjectCubit>()
                            .project
                            .applicationField = value,
                      ),
                      TitleInputField(
                        initialValue: context
                            .watch<RegisterProjectCubit>()
                            .project
                            .projectCode,
                        title: '輸入專案代碼',
                        hintText: 'Project code',
                        onChanged: (value) => context
                            .read<RegisterProjectCubit>()
                            .project
                            .projectCode = value,
                      ),
                      TitleInputField(
                        initialValue: context
                            .watch<RegisterProjectCubit>()
                            .project
                            .projectKey,
                        title: '輸入專案金鑰',
                        hintText: 'Project Key',
                        obscureText: true,
                        onChanged: (value) => context
                            .read<RegisterProjectCubit>()
                            .project
                            .projectKey = value,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20.0),
                  ),
                  onPressed:
                      context.read<RegisterProjectCubit>().registerProject,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 50.0,
                    ),
                    child: Text('送出'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
