import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:water_pressure_iot/models/sensor_data.dart';
import 'package:water_pressure_iot/screens/sensors/dashboard_card.dart';

class DashboardChartCard extends StatelessWidget {
  final List<SensorData> dataList;

  const DashboardChartCard({
    super.key,
    this.dataList = const [],
  });

  @override
  Widget build(BuildContext context) {
    return DashBoardCard(
      margin: const EdgeInsets.only(
        left: 8,
        right: 16,
        bottom: 16,
      ),
      child: dataList.isEmpty
          ? const Center(
              child: Text(
                '此感測器無資料',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : SfSparkLineChart(
              //Enable the trackball
              trackball: const SparkChartTrackball(
                activationMode: SparkChartActivationMode.tap,
              ),
              //Enable marker
              marker: const SparkChartMarker(
                displayMode: SparkChartMarkerDisplayMode.all,
              ),
              //Enable data label
              labelDisplayMode: SparkChartLabelDisplayMode.all,
              data: dataList
                  .map(
                    (e) => (e.pressure ?? 0).toDouble(),
                  )
                  .toList(),
            ),
    );
  }
}
