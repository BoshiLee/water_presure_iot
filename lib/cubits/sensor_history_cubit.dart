import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:water_pressure_iot/models/sensor.dart';

part 'sensor_history_state.dart';

class SensorHistoryCubit extends Cubit<SensorHistoryState> {
  final Sensor sensor;

  SensorHistoryCubit({
    required this.sensor,
  }) : super(SensorHistoryInitial());

  get html => null;

  void _exportToCsv() async {
    List<List<dynamic>> csvData = [
      ['Pressure', 'Date']
    ];

    for (var data in sensor.sensorData ?? []) {
      csvData.add([data.pressure, data.timestamp.toString()]);
    }

    String csvString = const ListToCsvConverter().convert(csvData);

    if (Platform.isAndroid || Platform.isIOS) {
      Directory? directory = await getExternalStorageDirectory();
      if (directory != null) {
        final String filePath = '${directory.path}/${sensor.name}_history.csv';
        File file = File(filePath);
        await file.writeAsString(csvString);
      }
    } else if (kIsWeb) {
      final blob = html.Blob([csvString]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "${sensor.name}_history.csv")
        ..click();

      html.Url.revokeObjectUrl(url);
    }
    emit(SensorHistoryDidExport());
  }
}
