import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:water_pressure_iot/cubits/sensors_cubit.dart';
import 'package:water_pressure_iot/screens/sensors/dashboard_plot_card.dart';

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
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: gridItemWidth / gridItemHeight,
            ),
            itemBuilder: (BuildContext context, int index) {
              return DashboardChartCard(
                sensor: context.read<SensorsCubit>().sensors[index],
                dataList:
                    context.read<SensorsCubit>().sensors[index].sensorData ??
                        [],
              );
            },
            itemCount: context.read<SensorsCubit>().sensors.length,
          );
        },
      ),
    );
  }
}
