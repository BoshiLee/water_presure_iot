import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/app/app_cubit.dart';
import 'package:water_pressure_iot/cubits/login/login_cubit.dart';
import 'package:water_pressure_iot/screens/login/login_screen.dart';
import 'package:water_pressure_iot/screens/login/welecome_screen.dart';
import 'package:water_pressure_iot/screens/main/main_screen.dart';

class App extends StatelessWidget {
  final botToastBuilder = BotToastInit();

  App({super.key});

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..startApp(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          child = Scaffold(
            // Global GestureDetector that will dismiss the keyboard
            body: GestureDetector(
              onTap: () {
                hideKeyboard(context);
              },
              child: child,
            ),
          );
          child = botToastBuilder(context, child);
          return child;
        },
        navigatorObservers: [BotToastNavigatorObserver()],
        title: '壓力計顯示系統',
        home: BlocConsumer<AppCubit, AppState>(
          buildWhen: (previous, current) {
            return current is AppAuthenticated || current is AppNotLogin;
          },
          listener: (context, state) {
            if (state is AppUninitialized) {
              BotToast.showSimpleNotification(title: '初始化網頁中');
            }
            if (state is AppInitialized) {
              BotToast.showSimpleNotification(title: '初始化完成');
            }
            if (state is AppLoading) {
              BotToast.showLoading();
            }
          },
          builder: (context, state) {
            if (state is AppAuthenticated) {
              return MainScreen();
            }
            if (state is AppNotLogin) {
              return const LoginScreen();
            }
            return const WelcomeScreen();
          },
        ),
      ),
    );
  }
}
