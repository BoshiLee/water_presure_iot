import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:water_pressure_iot/models/chart_data.dart';
import 'package:water_pressure_iot/models/sensor.dart';

class ChartWidget extends StatelessWidget {
  final Sensor sensor;

  ChartWidget({required this.sensor});

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = convertSensorDataToChartData(sensor.sensorData);

    return Container(
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        // legend: const Legend(isVisible: true),
        series: <ChartSeries>[
          LineSeries<ChartData, DateTime>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.date,
            yValueMapper: (ChartData data, _) => data.pressure,
            // name: sensor.nameIdentity ?? '',
          ),
        ],
      ),
    );
  }
}
