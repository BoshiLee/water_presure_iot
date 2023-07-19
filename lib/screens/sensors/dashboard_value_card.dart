import 'package:flutter/material.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/models/sensor_data.dart';
import 'package:water_pressure_iot/screens/sensors/dashboard_card.dart';

class DashboardValueCard extends StatelessWidget {
  final Sensor? sensor;
  const DashboardValueCard({
    super.key,
    this.sensor,
  });

  SensorData? get sensorData => sensor?.sensorData?.last;

  @override
  Widget build(BuildContext context) {
    return DashBoardCard(
      margin: const EdgeInsets.only(
        left: 16,
        right: 8,
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Latest Pressure Value:',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Center(
              child: Text.rich(
                TextSpan(
                  text: sensorData?.pressure?.toString() ?? '--',
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 35,
                    fontFamily: 'Roboto',
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: sensor?.unit ?? 'kgf',
                      style: const TextStyle(
                        fontSize: 26,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                strutStyle: const StrutStyle(
                  fontFamily: 'Roboto',
                  height: 1.0,
                ),
              ),
            ),
          ),
          Text(
            sensor?.nameIdentity ?? 'Sensor',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
