import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/register/device/register_device_cubit.dart';
import 'package:water_pressure_iot/screens/routing/dialog_helper.dart';
import 'package:water_pressure_iot/screens/routing/navigator_extension.dart';

class RegisterDeviceScreen extends StatelessWidget {
  static const id = 'register_Device_screen';

  const RegisterDeviceScreen({super.key});

  // This shows a CupertinoModalPopup which hosts a CupertinoAlertDialog.

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
          if (state is RegisterDeviceSuccess) {
            showAlertDialog(
              context,
              title: '註冊成功',
              content: '點擊確認返回登入畫面',
              defaultActionText: '確認',
              defaultAction: () {
                NavigatorExtension.popToRoot(context);
              },
            );
          }
          if (state is RegisterDeviceFailure) {
            BotToast.showText(text: state.error);
          }
          if (state is RegisterDeviceLoading) {
            BotToast.showLoading();
          }
          if (state is RegisterDeviceLoaded) {
            BotToast.closeAllLoading();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      color: index % 2 == 0 ? Colors.red : Colors.blue,
                    );
                  },
                ),
              ),
              // Expanded(
              //   child: RegisterDeviceForm(
              //     initDevice: const Device(
              //       name: '',
              //       description: '',
              //       uri: '',
              //       type: '',
              //     ),
              //     onChanged: (value) {},
              //   )
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {},
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
