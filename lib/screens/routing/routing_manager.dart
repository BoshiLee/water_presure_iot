import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/register/register_cubit.dart';
import 'package:water_pressure_iot/screens/register/register_project_screen.dart';
import 'package:water_pressure_iot/screens/register/register_project_tutor_screen.dart';
import 'package:water_pressure_iot/screens/register/register_screen.dart';
import 'package:water_pressure_iot/screens/routing/navigator_extension.dart';

typedef FutureFunc = Future<void> Function();

class RoutingManager {
  static Widget closeCurrentScreenIcon(
    BuildContext context, {
    FutureFunc? onClose,
    Color? color,
    IconData? icon,
  }) =>
      IconButton(
        icon: Icon(
          icon ?? Icons.close,
          color: color,
        ),
        onPressed: () async {
          await onClose?.call();
          Navigator.pop(context);
        },
      );

  static Widget returnPreviousScreenIcon(
    BuildContext context, {
    Color? color,
    VoidCallback? onClose,
  }) =>
      IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: color,
        ),
        onPressed: () {
          onClose?.call();
          Navigator.pop(context);
        },
      );

  static void pushToRegisterScreen(
    BuildContext context,
  ) =>
      NavigatorExtension.navigateToNextPage(
        context,
        BlocProvider(
          create: (context) {
            return RegisterCubit();
          },
          child: const RegisterScreen(),
        ),
        RegisterScreen.id,
      );

  static void pushToRegisterProjectTutorScreen(
    BuildContext context,
  ) =>
      NavigatorExtension.navigateToNextPage(
        context,
        const RegisterProjectTutorScreen(),
        RegisterProjectTutorScreen.id,
      );

  static void pushToRegisterProjectScreen(
    BuildContext context,
  ) =>
      NavigatorExtension.navigateToNextPage(
        context,
        RegisterProjectScreen(),
        RegisterProjectScreen.id,
      );
}
