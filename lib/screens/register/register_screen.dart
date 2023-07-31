import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/register/register_cubit.dart';
import 'package:water_pressure_iot/screens/login/account_input_field.dart';

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailure) {
            BotToast.showSimpleNotification(title: state.errorMessage);
          }
        },
        builder: (context, stata) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '請輸入用戶名稱',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  AccountInputField(
                    // initialValue: context.watch<LoginCubit>().auth.email ?? '',
                    hintText: 'Username',
                    onChanged: (value) =>
                        context.read<RegisterCubit>().auth.name = value,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '請輸入用戶 Email',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  AccountInputField(
                    // initialValue: context.watch<LoginCubit>().auth.email ?? '',
                    hintText: 'E-mail',
                    onChanged: (value) =>
                        context.read<RegisterCubit>().auth.email = value,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '請輸入用戶密碼',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  AccountInputField(
                    // initialValue: context.watch<LoginCubit>().auth.email ?? '',
                    hintText: 'Password',
                    obscureText: true,
                    onChanged: (value) =>
                        context.read<RegisterCubit>().auth.password = value,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '請再次輸入用戶密碼',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  AccountInputField(
                    // initialValue: context.watch<LoginCubit>().auth.email ?? '',
                    hintText: 'Enter Password Again',
                    obscureText: true,
                    onChanged: (value) => context
                        .read<RegisterCubit>()
                        .auth
                        .passwordConfirmation = value,
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20.0),
                ),
                onPressed: context.read<RegisterCubit>().register,
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 50.0,
                  ),
                  child: Text('送出'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}