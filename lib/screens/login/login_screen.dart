import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/constants/colors.dart';
import 'package:water_pressure_iot/cubits/app/app_cubit.dart';
import 'package:water_pressure_iot/cubits/login/login_cubit.dart';
import 'package:water_pressure_iot/icons/nbiot_icons.dart';
import 'package:water_pressure_iot/screens/login/account_input_field.dart';
import 'package:water_pressure_iot/screens/login/remember_me_checkbox.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginError) {
                BotToast.showSimpleNotification(title: state.message);
              }
              if (state is LoginLoading) {
                BotToast.showLoading();
              }
              if (state is LoginLoaded) {
                BotToast.closeAllLoading();
              }
              if (state is LoginSuccess) {
                BotToast.closeAllLoading();
                BotToast.showSimpleNotification(
                  title: "Hi, ${state.account.name} 歡迎您回來",
                );
                context.read<AppCubit>().authenticator();
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 40.0),
                    child: const Column(
                      children: [
                        Icon(
                          Nbiot.itri_logo,
                          size: 150,
                          color: itri_blue,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          '壓力計顯示系統',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: itri_black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AccountInputField(
                    initialValue: context.watch<LoginCubit>().auth.email ?? '',
                    hintText: 'E-mail',
                    onChanged: (value) {
                      context.read<LoginCubit>().auth.email = value;
                    },
                  ),
                  AccountInputField(
                    initialValue:
                        context.watch<LoginCubit>().auth.password ?? '',
                    hintText: 'Password',
                    onChanged: (value) {
                      context.read<LoginCubit>().auth.password = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 20.0),
                    child: RememberMeCheckBox(
                      initialValue: context.watch<LoginCubit>().rememberMail,
                      onChanged: (value) {
                        context.read<LoginCubit>().rememberMail = value;
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20.0),
                    ),
                    onPressed: context.read<LoginCubit>().login,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 50.0,
                      ),
                      child: Text('登入'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}