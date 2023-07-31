import 'package:flutter/material.dart';
import 'package:water_pressure_iot/constants/colors.dart';
import 'package:water_pressure_iot/icons/nbiot_icons.dart';

class LoginLogoWidgets extends StatelessWidget {
  const LoginLogoWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(
          Nbiot.itri_logo,
          size: 150,
          color: itri_blue,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          '壓力計顯示系統',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: itri_black,
          ),
        ),
      ],
    );
  }
}
