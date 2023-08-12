import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:water_pressure_iot/constants/colors.dart';
import 'package:water_pressure_iot/cubits/register/device/register_device_cubit.dart';
import 'package:water_pressure_iot/screens/register/wigets/register_device_form.dart';
import 'package:water_pressure_iot/screens/routing/dialog_helper.dart';
import 'package:water_pressure_iot/screens/routing/navigator_extension.dart';

class RegisterDeviceScreen extends StatefulWidget {
  static const id = 'register_Device_screen';

  const RegisterDeviceScreen({super.key});

  @override
  State<RegisterDeviceScreen> createState() => _RegisterDeviceScreenState();
}

class _RegisterDeviceScreenState extends State<RegisterDeviceScreen> {
  late int _currentPage;
  late PageController _controller;

  @override
  void initState() {
    _currentPage = 0;
    _controller = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );
    super.initState();
  }

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
                  onPageChanged: (value) => setState(
                    () => _currentPage = value,
                  ),
                  controller: _controller,
                  itemCount:
                      context.watch<RegisterDeviceCubit>().chtDevices.length,
                  itemBuilder: (context, index) => RegisterDeviceForm(
                    initDevice:
                        context.read<RegisterDeviceCubit>().chtDevices[index],
                    onChanged: (value) {
                      context.read<RegisterDeviceCubit>().devices[index] =
                          value;
                    },
                  ),
                ),
              ),
              if (context.watch<RegisterDeviceCubit>().chtDevices.length > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: PageViewDotIndicator(
                    currentItem: _currentPage,
                    count:
                        context.watch<RegisterDeviceCubit>().chtDevices.length,
                    unselectedColor: Colors.black26,
                    selectedColor: itri_blue,
                    duration: const Duration(milliseconds: 200),
                    boxShape: BoxShape.circle,
                    onItemClicked: (index) {
                      _controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ElevatedButton(
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
              const SizedBox(height: 20.0),
            ],
          );
        },
      ),
    );
  }
}
