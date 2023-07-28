import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/sensor_history/sensor_history_cubit.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/models/sensor_data.dart';
import 'package:water_pressure_iot/screens/sensors/chart/chart_widget.dart';
import 'package:water_pressure_iot/screens/sensors/chart/dashboard_card.dart';
import 'package:water_pressure_iot/screens/sensors/chart/sensor_history_dialog.dart';

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

  void _showHistoryDialog(BuildContext context, Sensor sensor) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => SensorHistoryCubit(sensor: sensor),
        child: const SensorHistoryDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DashBoardCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, // 將Text和ElevatedButton置中
            children: [
              // Expanded(child: Container()),
              IconButton(
                onPressed: () {
                  // _showHistoryDialog(context, sensor);
                },
                icon: const Icon(
                  Icons.list_alt,
                  color: Colors.transparent,
                ), // 使用icon作為按鈕內容
              ),
              Expanded(
                child: Text.rich(
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
                  textAlign: TextAlign.center,
                  strutStyle: const StrutStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    height: 1.0,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (sensor == null) {
                    return;
                  }
                  _showHistoryDialog(context, sensor!);
                },
                icon: const Icon(Icons.list_alt), // 使用icon作為按鈕內容
              ),
            ],
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
