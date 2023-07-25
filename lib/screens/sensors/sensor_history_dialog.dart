import 'package:flutter/material.dart';
import 'package:water_pressure_iot/models/sensor.dart';

class SensorHistoryDialog extends StatelessWidget {
  final Sensor sensor;

  const SensorHistoryDialog({
    Key? key,
    required this.sensor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${sensor.name} Pressure History'),
          IconButton(
            color: Colors.redAccent[400],
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () {
            // _exportToCsv();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blueAccent[400],
            ),
            child: const Padding(
              padding: EdgeInsets.all(10), // 設置按鈕內容的padding
              child: Text(
                'Export to CSV',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
        ),
      ],
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: sensor.sensorData?.length ?? 0,
          itemBuilder: (context, index) {
            var data = sensor.sensorData![index];
            return ListTile(
              title: Text('Pressure: ${data.pressure}'),
              subtitle: Text('Date: ${data.timestamp}'),
            );
          },
        ),
      ),
    );
  }
}
