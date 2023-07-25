import 'package:flutter/material.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/models/sensor_data.dart';
import 'package:water_pressure_iot/screens/sensors/chart_widget.dart';
import 'package:water_pressure_iot/screens/sensors/dashboard_card.dart';

class DashboardChartCard extends StatelessWidget {
  final Sensor? sensor;
  final List<SensorData> dataList;

  const DashboardChartCard({
    super.key,
    this.sensor,
    this.dataList = const [],
  });

  SensorData? get sensorData {
    if (dataList.isEmpty) {
      return null;
    }
    return dataList.last;
  }

  @override
  Widget build(BuildContext context) {
    return DashBoardCard(
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: '${sensor?.nameIdentity ?? 'Sensor Name'}: ',
              children: <TextSpan>[
                TextSpan(
                  text: sensorData?.pressure?.toString() ?? '--',
                  style: const TextStyle(
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextSpan(
                  text: '  ${sensor?.unit ?? 'kgf'}',
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            strutStyle: const StrutStyle(
              fontSize: 20,
              fontFamily: 'Roboto',
              height: 1.0,
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: sensor == null || dataList.isEmpty
                ? const Center(
                    child: Text(
                      '此感測器無資料',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Expanded(
                    child: ChartWidget(sensor: sensor!),
                  ),
          ),
        ],
      ),
    );
  }
}
