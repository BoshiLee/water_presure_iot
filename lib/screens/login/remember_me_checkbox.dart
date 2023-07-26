import 'package:flutter/material.dart';

class RememberMeCheckBox extends StatefulWidget {
  const RememberMeCheckBox({
    super.key,
    required this.initialValue,
    this.onChanged,
  });

  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  @override
  State<RememberMeCheckBox> createState() => _RememberMeCheckBoxState();
}

class _RememberMeCheckBoxState extends State<RememberMeCheckBox> {
  bool _isChecked = false;

  @override
  void initState() {
    _isChecked = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text(
          '記住我',
          style: TextStyle(fontSize: 20.0),
        ),
        Checkbox(
          checkColor: Colors.white,
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() => _isChecked = value!);
            widget.onChanged?.call(value!);
          },
        )
      ],
    );
  }
}
