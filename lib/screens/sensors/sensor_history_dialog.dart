import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/sensor_history_cubit.dart';
import 'package:water_pressure_iot/models/sensor.dart';

class SensorHistoryDialog extends StatelessWidget {
  const SensorHistoryDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SensorHistoryCubit, SensorHistoryState>(
      listener: (context, state) {
        if (state is SensorHistoryConverted) {
          final blob = html.Blob([state.csvString]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", "${state.sensorName}_history.csv")
            ..click();

          html.Url.revokeObjectUrl(url);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Exported to CSV'),
            ),
          );
        }
      },
      builder: (context, state) {
        final Sensor sensor = context.read<SensorHistoryCubit>().sensor;
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
              onTap: () => context.read<SensorHistoryCubit>().exportToCsv(),
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
      },
    );
  }
}
