import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:water_pressure_iot/models/chart_data.dart';
import 'package:water_pressure_iot/models/sensor.dart';

class ChartWidget extends StatelessWidget {
  final Sensor sensor;

  ChartWidget({required this.sensor});

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = convertSensorDataToChartData(sensor.sensorData);

    return SfCartesianChart(
      // Set X tick to each day
      primaryXAxis: DateTimeAxis(
        intervalType: DateTimeIntervalType.days,
        dateFormat: DateFormat.MMMd(),
        interval: 1,
      ),
      // Set X ticker to Data and Set Y ticker to Pressure
      series: <ChartSeries>[
        LineSeries<double, DateTime>(
          dataSource:
              sensor.sensorData?.map((e) => e.pressure ?? 0).toList() ?? [],
          xValueMapper: (double pressure, index) =>
              sensor.sensorData?[index].timestamp ?? DateTime.now(),
          yValueMapper: (double pressure, _) => pressure,
          // name: sensor.nameIdentity ?? '',
        ),
      ],
    );
  }
}
