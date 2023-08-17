import 'package:water_pressure_iot/api/api_base_helper.dart';

class SensorProvider {
  static final ApiBaseHelper _helper = ApiBaseHelper();
  static const String _route = '/sensors';

  Future<Map<String, dynamic>?> fetchSensors() async =>
      await _helper.get('$_route/all');

  Future<Map<String, dynamic>?> updateSensorDataFromNbiot(int sensorId) async =>
      await _helper.get('$_route/$sensorId/update_from_nbiot');
}
