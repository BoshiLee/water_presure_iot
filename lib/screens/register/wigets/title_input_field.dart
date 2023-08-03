import 'package:flutter/material.dart';
import 'package:water_pressure_iot/screens/login/account_input_field.dart';

class TitleInputField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final bool obscureText;
  final String? initialValue;
  final Function(String)? onChanged;

  const TitleInputField({
    super.key,
    this.title,
    this.hintText,
    this.obscureText = false,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
            ),
          ),
        ),
        AccountInputField(
          initialValue: initialValue ?? '',
          hintText: hintText,
          obscureText: obscureText,
          onChanged: (value) => onChanged?.call(value),
        ),
      ],
    );
  }
}
