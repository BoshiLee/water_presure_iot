import 'package:flutter/material.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/screens/sensors/chart/dashboard_plot_card.dart';

class SensorsGridview extends StatelessWidget {
  final double gridItemWidth;
  final double gridItemHeight;
  final List<Sensor>? sensors;

  const SensorsGridview({
    super.key,
    required this.sensors,
    required this.gridItemWidth,
    required this.gridItemHeight,
  });

  @override
  Widget build(BuildContext context) {
    if (sensors == null || sensors!.isEmpty) {
      return const Center(
        child: Text('目前尚無壓力計資料'),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: gridItemWidth / gridItemHeight,
      ),
      itemBuilder: (BuildContext context, int index) {
        return DashboardChartCard(
          sensor: sensors![index],
          dataList: sensors![index].sensorData ?? [],
        );
      },
      itemCount: sensors!.length,
    );
  }
}
