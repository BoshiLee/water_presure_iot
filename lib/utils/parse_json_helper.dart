import 'package:water_pressure_iot/models/sensor.dart';

class ParseJsonHelper {
  static List<Sensor> parseSensors(Map<String, dynamic> json) {
    final List<Sensor> sensors = [];
    if (json['sensors'] == null) return sensors;
    json['sensors'].forEach((v) {
      sensors.add(Sensor.fromJson(v));
    });
    return sensors;
  }
}
