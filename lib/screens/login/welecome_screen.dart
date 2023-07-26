import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.water_damage,
              size: 150,
              color: Colors.blue,
            ),
            Text(
              '壓力計顯示系統',
              style: TextStyle(fontSize: 30),
            ),
            // Image.asset(
            //   'assets/logo.png', // 替換為你Logo的路徑
            //   width: 150,
            //   height: 150,
            // ),
          ],
        ),
      ),
    );
  }
}
