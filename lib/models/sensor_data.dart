import '../utils/date_helper.dart';

class SensorData {
  int? id;
  int? latitude;
  int? longitude;
  int? pressure;
  int? sensorId;
  String? sensorNameIdentity;
  DateTime? timestamp;

  SensorData({
    id,
    latitude,
    longitude,
    pressure,
    sensorId,
    sensorNameIdentity,
    timestamp,
  });

  SensorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    pressure = json['pressure'];
    sensorId = json['sensor_id'];
    sensorNameIdentity = json['sensor_name_identity'];
    timestamp = json['timestamp'] != null
        ? DateHelper.parseToLocal(json['timestamp'])
        : null;
  }
}
