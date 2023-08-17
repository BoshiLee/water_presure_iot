import 'package:flutter/material.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/screens/sensors/chart/dashboard_plot_card.dart';

class SensorChartTable extends StatelessWidget {
  final List<Sensor>? sensors;
  const SensorChartTable({
    super.key,
    this.sensors,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      shrinkWrap: true,
      itemCount: sensors?.length ?? 0,
      itemBuilder: (context, index) {
        return Container(
          constraints: const BoxConstraints(
            maxHeight: 250,
          ),
          child: DashboardChartCard(
            sensor: sensors![index],
            dataList: sensors![index].sensorData ?? [],
          ),
        );
      },
    );
  }
}
