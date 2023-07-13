import 'package:flutter/foundation.dart';
import 'package:water_pressure_iot/api/app_exception.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/utils/parse_json_helper.dart';

import '../provider/sensor_provider.dart';

class SensorRepository {
  final SensorProvider _sensorProvider = SensorProvider();

  Future<List<Sensor>> fetchSensors() async {
    final response = await _sensorProvider.fetchSensors();
    if (response == null) throw BadRequestException('無法取得壓力計資訊');
    return compute<Map<String, dynamic>, List<Sensor>>(
      ParseJsonHelper.parseSensors,
      response,
    );
  }
}
