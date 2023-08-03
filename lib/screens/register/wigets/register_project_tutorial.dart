import 'package:flutter/material.dart';
import 'package:water_pressure_iot/screens/register/wigets/tutor_image.dart';

class RegisterProjectTutorial extends StatelessWidget {
  const RegisterProjectTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: Text(
            '請至中華電信智慧聯網大平台申請專案，\n並依序輸入相關欄位資訊。',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.redAccent[400],
            ),
          ),
        ),
        const TutorImage(
          title: '1. 點擊最右方打開專案教學',
          imagePath: 'assets/images/open_project_key.png',
          size: 200,
        ),
        const TutorImage(
          title: '2. 輸入相關欄位',
          imagePath: 'assets/images/project_management.png',
          size: 340,
        ),
        const TutorImage(
          title: '3. 點擊紅框處打開專案教學',
          imagePath: 'assets/images/project_key.png',
          size: 160,
        ),
      ],
    );
  }
}
