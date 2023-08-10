import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/register/device/register_device_tutor_cubit.dart';
import 'package:water_pressure_iot/screens/register/wigets/register_device_tutorial.dart';
import 'package:water_pressure_iot/screens/routing/routing_manager.dart';

class RegisterDeviceTutorScreen extends StatelessWidget {
  static const id = 'register_device_tutor_screen';

  const RegisterDeviceTutorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('註冊設備教學'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<RegisterDeviceTutorCubit, RegisterDeviceTutorState>(
        listener: (context, state) {
          if (state is RegisterDeviceTutorFailure) {
            BotToast.showText(text: state.error);
          }
          if (state is RegisterDeviceTutorImportSuccess) {
            RoutingManager.pushToRegisterDeviceScreen(
              context,
              projectId: state.projectId,
              devices: state.devices,
            );
          }
          if (state is RegisterDeviceTutorLoading) {
            BotToast.showLoading();
          }
          if (state is RegisterDeviceTutorLoaded) {
            BotToast.closeAllLoading();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              const Expanded(
                child: SingleChildScrollView(
                  child: RegisterDeviceTutorial(),
                ),
              ),
              const Text(
                '點擊下方按鈕匯入設備資訊，並進入下一頁',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20.0),
                  ),
                  onPressed: context
                      .read<RegisterDeviceTutorCubit>()
                      .importDevicesFromCHT,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 50.0,
                    ),
                    child: Text('下一頁'),
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
