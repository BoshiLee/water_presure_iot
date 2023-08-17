import '../utils/date_helper.dart';

class SensorData {
  int? id;
  double? latitude;
  double? longitude;
  double? pressure;
  int? sensorId;
  String? sensorNameIdentity;
  DateTime? timestamp;

  SensorData({
    this.id,
    this.latitude,
    this.longitude,
    this.pressure,
    this.sensorId,
    this.sensorNameIdentity,
    this.timestamp,
  });

  SensorData.fromJson(Map<String, dynamic> json) {
    id = json.containsKey('id') ? json['id'] : null;
    latitude = json.containsKey('latitude') ? json['latitude'] : null;
    longitude = json.containsKey('longitude') ? json['longitude'] : null;
    pressure = json.containsKey('pressure') ? json['pressure'] : null;
    sensorId = json.containsKey('sensor_id') ? json['sensor_id'] : null;
    sensorNameIdentity = json.containsKey('sensor_name_identity')
        ? json['sensor_name_identity']
        : null;
    timestamp = json.containsKey('timestamp') && json['timestamp'] != null
        ? DateHelper.parseToLocal(json['timestamp'])
        : null;
  }
}
