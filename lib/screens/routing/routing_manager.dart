import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/register/device/register_device_cubit.dart';
import 'package:water_pressure_iot/cubits/register/device/register_device_tutor_cubit.dart';
import 'package:water_pressure_iot/cubits/register/project/register_project_cubit.dart';
import 'package:water_pressure_iot/cubits/register/register_cubit.dart';
import 'package:water_pressure_iot/models/device.dart';
import 'package:water_pressure_iot/screens/register/register_device_screen.dart';
import 'package:water_pressure_iot/screens/register/register_device_tutor_screen.dart';
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
        BlocProvider(
          create: (context) {
            return RegisterProjectCubit();
          },
          child: const RegisterProjectScreen(),
        ),
        RegisterProjectScreen.id,
      );

  static void pushToRegisterDeviceTutorScreen(
    BuildContext context, {
    required int projectId,
  }) =>
      NavigatorExtension.navigateToNextPage(
        context,
        BlocProvider(
          create: (context) {
            return RegisterDeviceTutorCubit(projectId: projectId);
          },
          child: const RegisterDeviceTutorScreen(),
        ),
        RegisterDeviceTutorScreen.id,
      );

  static void pushToRegisterDeviceScreen(
    BuildContext context, {
    required int projectId,
    required List<Device> devices,
  }) =>
      NavigatorExtension.navigateToNextPage(
        context,
        BlocProvider(
          create: (context) {
            return RegisterDeviceCubit(
              projectId: projectId,
              devices: devices,
            );
          },
          child: const RegisterDeviceScreen(),
        ),
        RegisterDeviceScreen.id,
      );
}
