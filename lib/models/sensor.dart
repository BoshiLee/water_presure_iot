import 'package:water_pressure_iot/models/sensor_data.dart';

class Sensor {
  String? description;
  int? deviceId;
  String? formula;
  int? id;
  String? name;
  String? nameIdentity;
  List<SensorData>? sensorData;
  String? sensorType;
  String? unit;
  String? uri;

  Sensor(
      {this.description,
      this.deviceId,
      this.formula,
      this.id,
      this.name,
      this.nameIdentity,
      this.sensorData,
      this.sensorType,
      this.unit,
      this.uri});

  Sensor.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    deviceId = json['device_id'];
    formula = json['formula'];
    id = json['id'];
    name = json['name'];
    nameIdentity = json['name_identity'];
    if (json['sensor_data'] != null) {
      sensorData = <SensorData>[];
      json['sensor_data'].forEach((v) {
        sensorData!.add(SensorData.fromJson(v));
      });
    }
    sensorType = json['sensor_type'];
    unit = json['unit'];
    uri = json['uri'];
  }
}
