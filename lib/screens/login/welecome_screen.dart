import 'package:flutter/material.dart';
import 'package:water_pressure_iot/constants/colors.dart';
import 'package:water_pressure_iot/icons/nbiot_icons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '壓力計顯示系統',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: itri_black,
                  ),
                ),
                SizedBox(
                  width: 42,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Nbiot.itri_logo,
                  size: 150,
                  color: itri_blue,
                ),
                SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Icon(
                      Nbiot.itri,
                      size: 60,
                      color: itri_black,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Icon(
                      Nbiot.itri_all,
                      size: 65,
                      color: itri_black,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
