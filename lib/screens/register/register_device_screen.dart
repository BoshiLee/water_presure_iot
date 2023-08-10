import 'package:flutter/material.dart';

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
      body: Column(
        children: [
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
      ),
    );
  }
}
