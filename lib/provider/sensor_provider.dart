import 'package:water_pressure_iot/api/api_base_helper.dart';
import 'package:water_pressure_iot/utils/date_helper.dart';

class SensorProvider {
  static final ApiBaseHelper _helper = ApiBaseHelper();
  static const String _route = '/sensors';

  Future<Map<String, dynamic>?> fetchSensors() async =>
      await _helper.get('$_route/all');

  Future<Map<String, dynamic>?> updateSensorDataFromNbiot(int sensorId) async =>
      await _helper.put('$_route/$sensorId/sensor_data/update_from_nbiot');

  Future<Map<String, dynamic>?> getLatestSensorDataFromNbiot(
          String latest) async =>
      await _helper.get('$_route/latest_from_nbiot',
          queryParameters: {'latest': latest});

  Future<Map<String, dynamic>?> importSensorsData({DateTime? startTime}) async {
    String? encode = startTime != null
        ? Uri.encodeQueryComponent(
      startTime.iso8601StringWithTimeOffset(),
    )
        : null;
    return await _helper.put(
      encode != null ? '/sensors/porting_sensors_data_from_nbiot' : '/sensors/porting_sensors_data_from_nbiot',
    );
  }
}
