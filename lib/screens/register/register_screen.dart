import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/register/register_cubit.dart';
import 'package:water_pressure_iot/screens/register/wigets/title_input_field.dart';
import 'package:water_pressure_iot/screens/routing/routing_manager.dart';

import '../widgets/custom_loading_widget.dart';

class RegisterScreen extends StatelessWidget {
  static const id = 'register_screen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('註冊'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            BotToast.showCustomLoading(
              toastBuilder: (_) => const CustomLoadingWidget(
                message: '註冊中...',
              ),
            );
          }
          if (state is RegisterSuccess) {
            RoutingManager.pushToRegisterProjectTutorScreen(context);
          }
          if (state is RegisterFailure) {
            BotToast.showSimpleNotification(title: state.errorMessage);
          }
          if (state is RegisterLoaded) {
            BotToast.closeAllLoading();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TitleInputField(
                        initialValue: context.read<RegisterCubit>().auth.name,
                        title: '請輸入用戶名稱',
                        hintText: 'Username',
                        onChanged: (value) =>
                            context.read<RegisterCubit>().auth.name = value,
                      ),
                      TitleInputField(
                        initialValue: context.read<RegisterCubit>().auth.email,
                        title: '請輸入用戶 Email',
                        hintText: 'E-mail',
                        onChanged: (value) =>
                            context.read<RegisterCubit>().auth.email = value,
                      ),
                      TitleInputField(
                        initialValue:
                            context.read<RegisterCubit>().auth.password,
                        title: '請輸入用戶密碼',
                        hintText: 'Password',
                        obscureText: true,
                        onChanged: (value) =>
                            context.read<RegisterCubit>().auth.password = value,
                      ),
                      TitleInputField(
                        initialValue: context
                            .read<RegisterCubit>()
                            .auth
                            .passwordConfirmation,
                        title: '請再次輸入用戶密碼',
                        hintText: 'Enter Password Again',
                        obscureText: true,
                        onChanged: (value) => context
                            .read<RegisterCubit>()
                            .auth
                            .passwordConfirmation = value,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20.0),
                  ),
                  onPressed: context.read<RegisterCubit>().register,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 50.0,
                    ),
                    child: Text('下一步'),
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
