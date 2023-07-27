import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:water_pressure_iot/cubits/sensors/sensors_cubit.dart';
import 'package:water_pressure_iot/cubits/sensors/sensors_data_table_cubit.dart';
import 'package:water_pressure_iot/screens/sensors/sensors_page_view.dart';

class SensorsScreen extends StatelessWidget {
  const SensorsScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final gridItemWidth = screenWidth / 2;
    final gridItemHeight = (screenHeight) / 1.75;
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fd),
      body: BlocBuilder<SensorsCubit, SensorsState>(
        builder: (context, state) {
          if (state is SensorsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SensorsLoaded && state.sensors.isEmpty) {
            return const Center(
              child: Text('目前尚無壓力計資料'),
            );
          } else if (state is SensorsLoaded) {
            return BlocProvider(
              create: (context) => SensorsDataTableCubit(
                state.sensors,
                const Duration(minutes: 1),
              ),
              child: SensorsTabbedPage(
                sensors: state.sensors,
                gridItemWidth: gridItemWidth,
                gridItemHeight: gridItemHeight,
              ),
            );
          } else {
            return const Center(
              child: Text('無法獲取壓力計資料'),
            );
          }
        },
      ),
    );
  }
}
