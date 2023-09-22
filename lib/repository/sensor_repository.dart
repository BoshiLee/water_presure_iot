import 'package:flutter/foundation.dart';
import 'package:water_pressure_iot/api/app_exception.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/models/sensor_data.dart';
import 'package:water_pressure_iot/utils/date_helper.dart';
import 'package:water_pressure_iot/utils/parse_json_helper.dart';

import '../api/api_response.dart';
import '../provider/register_provider.dart';
import '../provider/sensor_provider.dart';

class SensorRepository {
  final SensorProvider _sensorProvider = SensorProvider();
  final RegisterProvider _regisProvider = RegisterProvider();

  Future<List<Sensor>> fetchSensors() async {
    final response = await _sensorProvider.fetchSensors();
    if (response == null) throw BadRequestException('無法取得壓力計資訊');
    return compute<Map<String, dynamic>, List<Sensor>>(
      ParseJsonHelper.parseSensors,
      response,
    );
  }

  Future<List<SensorData>> updateFromNBIOT(int sensorId) async {
    final response = await _sensorProvider.updateSensorDataFromNbiot(sensorId);
    if (response == null) throw BadRequestException('無法取得壓力計資訊');
    return compute<Map<String, dynamic>, List<SensorData>>(
      ParseJsonHelper.parseSensorDataList,
      response,
    );
  }

  Future<List<Sensor>> getLatestFromNBIOT(DateTime latest) async {
    final response = await _sensorProvider.getLatestSensorDataFromNbiot(
      latest.iso8601StringWithTimeOffset(),
    );
    if (response == null) throw BadRequestException('無法取得壓力計資訊');
    return compute<Map<String, dynamic>, List<Sensor>>(
      ParseJsonHelper.parseSensors,
      response,
    );
  }

  Future<ApiResponse> importSensorDataFromCHT({
    required DateTime startTime,
  }) async {
    try {
      final response = await _regisProvider.importSensorsData(startTime);
      if (response == null) throw BadRequestException('匯入失敗，請稍後再試');
      return compute<Map<String, dynamic>, ApiResponse>(
        ParseJsonHelper.parseApiResponse,
        response,
      );
    } catch (e) {
      throw BadRequestException(e.toString());
    }
  }
}
