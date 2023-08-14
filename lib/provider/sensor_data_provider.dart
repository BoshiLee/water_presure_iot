import 'package:water_pressure_iot/api/api_base_helper.dart';

class SensorDataProvider {
  static final ApiBaseHelper _helper = ApiBaseHelper();
  static const String _route = '/sensors';

  Future<Map<String, dynamic>?> fetchSensorData(int id) async =>
      await _helper.get('$_route/$id/all');

  Future<Map<String, dynamic>?> portingDataFromCHT(int id) async =>
      await _helper.get('$_route/$id/porting_from_nbiot');
}
