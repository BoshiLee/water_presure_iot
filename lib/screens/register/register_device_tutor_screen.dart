import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: RegisterDeviceTutorial(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                RoutingManager.pushToRegisterDeviceScreen(context);
              },
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
      ),
    );
  }
}
