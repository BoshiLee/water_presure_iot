import 'package:flutter/material.dart';
import 'package:water_pressure_iot/screens/register/wigets/title_input_field.dart';
import 'package:water_pressure_iot/screens/routing/routing_manager.dart';

class RegisterProjectScreen extends StatelessWidget {
  static const id = 'register_project_screen';

  const RegisterProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('註冊專案'),
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
                      '請輸入專案資訊',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TitleInputField(
                    title: '輸入專案名稱',
                    hintText: 'Project Name',
                    onChanged: (value) {},
                  ),
                  TitleInputField(
                    title: '輸入專案描述',
                    hintText: 'Project Description',
                    onChanged: (value) {},
                  ),
                  TitleInputField(
                    title: '輸入專案領域',
                    hintText: 'Project Application Field',
                    onChanged: (value) {},
                  ),
                  TitleInputField(
                    title: '輸入專案代碼',
                    hintText: 'Project code',
                    onChanged: (value) {},
                  ),
                  TitleInputField(
                    title: '輸入專案金鑰',
                    hintText: 'Project Key',
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
              onPressed: () {
                RoutingManager.pushToRegisterDeviceTutorScreen(context);
              },
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
