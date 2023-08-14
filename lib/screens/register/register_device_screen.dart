import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/app/app_cubit.dart';
import 'package:water_pressure_iot/cubits/register/device/register_device_cubit.dart';
import 'package:water_pressure_iot/models/device.dart';
import 'package:water_pressure_iot/screens/register/register_device_page.dart';
import 'package:water_pressure_iot/screens/routing/dialog_helper.dart';
import 'package:water_pressure_iot/screens/routing/navigator_extension.dart';
import 'package:water_pressure_iot/screens/widgets/custom_loading_widget.dart';

class RegisterDeviceScreen extends StatelessWidget {
  static const id = 'register_Device_screen';

  const RegisterDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('註冊設備'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<RegisterDeviceCubit, RegisterDeviceState>(
        listener: (context, state) {
          if (state is RegisterDeviceSImportSensorsDataSuccess) {
            BotToast.showSimpleNotification(title: state.message);
            context.read<AppCubit>().authenticator();
            NavigatorExtension.popToRoot(context);
          }
          if (state is RegisterDeviceSuccess) {
            showAlertDialog(
              context,
              title: '註冊成功',
              content: '點擊確認開始匯入感測器資料',
              destructiveActionText: '確認',
              destructiveAction: () {
                context.read<RegisterDeviceCubit>().portingSensor();
                Navigator.pop(context);
              },
            );
          }
          if (state is RegisterDeviceFailure) {
            BotToast.showText(text: state.error);
          }
          if (state is RegisterDeviceLoading) {
            BotToast.showCustomLoading(
              toastBuilder: (_) => CustomLoadingWidget(
                message: state.message ?? '匯入資料中...',
              ),
            );
          }
          if (state is RegisterDeviceLoaded) {
            BotToast.closeAllLoading();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: RegisterDevicePage(
                  onDeviceChange: (int index, Device value) {
                    context.read<RegisterDeviceCubit>().devices[index] = value;
                  },
                  devices: context.watch<RegisterDeviceCubit>().devices,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20.0),
                ),
                onPressed: context.read<RegisterDeviceCubit>().registerDevices,
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 50.0,
                  ),
                  child: Text('送出'),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          );
        },
      ),
    );
  }
}
