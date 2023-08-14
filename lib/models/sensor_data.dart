import '../utils/date_helper.dart';

class SensorData {
  String? id;
  double? latitude;
  double? longitude;
  double? pressure;
  String? sensorId;
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
    id = json.containsKey('id') ? json['id'] : '';
    latitude = json.containsKey('latitude') ? json['latitude'] : 0.0;
    longitude = json.containsKey('longitude') ? json['longitude'] : 0.0;
    pressure = json.containsKey('pressure') ? json['pressure'] : 0.0;
    sensorId = json.containsKey('sensor_id') ? json['sensor_id'] : '';
    sensorNameIdentity = json.containsKey('sensor_name_identity')
        ? json['sensor_name_identity']
        : '';
    timestamp = json.containsKey('timestamp') && json['timestamp'] != null
        ? DateHelper.parseToLocal(json['timestamp'])
        : null;
  }
}
