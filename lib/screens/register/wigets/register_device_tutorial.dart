import 'package:flutter/material.dart';
import 'package:water_pressure_iot/screens/register/wigets/tutor_image.dart';

class RegisterDeviceTutorial extends StatelessWidget {
  const RegisterDeviceTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: Text(
            '請至中華電信智慧聯網大平台申請設備，\n並依序輸入相關欄位資訊。',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.redAccent[400],
            ),
          ),
        ),
        const TutorImage(
          title: '1. 點擊紅框處打開設備管理',
          imagePath: 'assets/images/open_device.png',
          size: 220,
          imageFit: BoxFit.contain,
        ),
        const TutorImage(
          title: '2. 依序填寫相關欄位',
          imagePath: 'assets/images/device_management.png',
          size: 340,
        ),
      ],
    );
  }
}
