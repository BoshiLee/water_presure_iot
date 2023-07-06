import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:water_pressure_iot/screens/main_screen.dart';

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
    return MaterialApp(
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
      home: MainScreen(),
    );
  }
}
