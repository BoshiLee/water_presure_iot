import 'package:flutter/material.dart';
import 'package:water_pressure_iot/models/sensor.dart';

class SensorDataTable extends StatelessWidget {
  final List<Sensor> sensors;
  final List<List<String>> dataTable;

  const SensorDataTable({
    super.key,
    required this.sensors,
    required this.dataTable,
  });

  List<Widget> _buildRows(List<String> dataRow) {
    return dataRow
        .map(
          (e) => Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Text(e),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (sensors.isEmpty) {
      return const Center(
        child: Text('目前尚無壓力計資料'),
      );
    }
    // 取得所有sensor的sensorData，並合併成一個列表
    return ListView.builder(
      itemCount: dataTable.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildRows(dataTable[index]),
        );
      },
    );
  }
}
