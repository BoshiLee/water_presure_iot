import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:water_pressure_iot/constants/page_titles.dart';
import 'package:water_pressure_iot/screens/sensors/sensors_screen.dart';

class MainContentScreen extends StatelessWidget {
  const MainContentScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = PageTitle.getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return SensorsScreen(controller: controller);
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}
