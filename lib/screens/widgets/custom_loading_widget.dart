import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  static const id = 'custom_loading_widget';
  final String message;
  const CustomLoadingWidget({super.key, this.message = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
