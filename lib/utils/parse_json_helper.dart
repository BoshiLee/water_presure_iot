import 'package:water_pressure_iot/api/api_response.dart';
import 'package:water_pressure_iot/models/account.dart';
import 'package:water_pressure_iot/models/device.dart';
import 'package:water_pressure_iot/models/project.dart';
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

  static Account? parseAccount(Map<String, dynamic> json) {
    if (json['account'] == null) return null;
    return Account.fromJson(json['account']);
  }

  static ApiResponse parseApiResponse(Map<String, dynamic> json) {
    return ApiResponse.fromJson(json);
  }

  static Project parseProject(Map<String, dynamic> json) {
    return Project.fromJson(json);
  }

  static Device parseDevice(Map<String, dynamic> json) {
    return Device.fromJson(json);
  }

  static List<Device> parseDevices(Map<String, dynamic> json) {
    final List<Device> devices = [];
    if (json['devices'] == null) return devices;
    json['devices'].forEach((v) {
      devices.add(parseDevice(json));
    });
    return devices;
  }
}
