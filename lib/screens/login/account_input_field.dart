import 'package:flutter/material.dart';

class AccountInputField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;
  final String initialValue;

  const AccountInputField({
    super.key,
    this.initialValue = '',
    this.hintText,
    required this.onChanged,
  });

  @override
  State<AccountInputField> createState() => _AccountInputFieldState();
}

class _AccountInputFieldState extends State<AccountInputField> {
  String value = '';

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: TextField(
        controller: TextEditingController(
          text: value,
        ),
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          this.value = value;
          widget.onChanged(value);
        },
      ),
    );
  }
}
