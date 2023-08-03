import 'package:flutter/material.dart';
import 'package:water_pressure_iot/screens/register/wigets/title_input_field.dart';

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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '請輸入設備資訊',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TitleInputField(
                    title: '輸入設備名稱',
                    hintText: 'Device Name',
                    onChanged: (value) {},
                  ),
                  TitleInputField(
                    title: '輸入設備描述',
                    hintText: 'Device Description',
                    onChanged: (value) {},
                  ),
                  TitleInputField(
                    title: '輸入設備 uri',
                    hintText: 'Device uri',
                    onChanged: (value) {},
                  ),
                  TitleInputField(
                    title: '輸入設備類型',
                    hintText: 'Device Type',
                    onChanged: (value) {},
                  ),
                  // TitleInputField(
                  //   title: '輸入設備代碼',
                  //   hintText: 'Device number',
                  //   onChanged: (value) {},
                  // ),
                  TitleInputField(
                    title: '輸入設備金鑰',
                    hintText: 'Device Key',
                    obscureText: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
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
