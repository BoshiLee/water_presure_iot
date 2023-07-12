import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SensorsScreen extends StatelessWidget {
  const SensorsScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fd),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) => Container(
          height: 100,
          width: double.infinity,
          margin: const EdgeInsets.only(
            bottom: 10,
            right: 10,
            left: 10,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.5),
            boxShadow: const [
              BoxShadow(
                color: Color(0xfff2f4f7),
                blurRadius: 0.3,
                offset: Offset(1.8, 1.8),
              )
            ],
          ),
          child: Text(
            'Sensor $index',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
