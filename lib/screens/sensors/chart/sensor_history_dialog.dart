import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/sensor_history/sensor_history_cubit.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/utils/sava_file_html.dart';

class SensorHistoryDialog extends StatelessWidget {
  const SensorHistoryDialog({
    Key? key,
  }) : super(key: key);

  List<Widget> _buildRows(List<String> dataRow) {
    return dataRow
        .map(
          (e) => Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 50,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Text(e),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SensorHistoryCubit, SensorHistoryState>(
      listener: (context, state) {
        if (state is SensorHistoryConverted) {
          webDownloadFile(state.csvString, "${state.sensorName}_history.csv");
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${sensor.name} History'),
                  IconButton(
                    color: Colors.redAccent[400],
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
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
          content: Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildRows(
                    ['Time', 'Pressure'],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemExtent: 50,
                    itemCount: sensor.sensorData?.length ?? 0,
                    itemBuilder: (context, index) {
                      var data = sensor.sensorData![index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _buildRows(
                          [
                            data.timestamp.toString(),
                            data.pressure.toString(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
