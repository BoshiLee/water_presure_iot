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

  Sensor({
    this.description,
    this.deviceId,
    this.formula,
    this.id,
    this.name,
    this.nameIdentity,
    this.sensorData,
    this.sensorType,
    this.unit,
    this.uri,
  });

  Sensor.fromJson(Map<String, dynamic> json) {
    id = json.containsKey('id') ? json['id'] : null;
    nameIdentity =
        json.containsKey('name_identity') ? json['name_identity'] : '';
    name = json.containsKey('name') ? json['name'] : '';
    description = json.containsKey('description') ? json['description'] : '';
    deviceId = json.containsKey('device_id') ? json['device_id'] : null;
    formula = json.containsKey('formula') ? json['formula'] : '';
    sensorType = json.containsKey('sensor_type') ? json['sensor_type'] : '';
    uri = json.containsKey('uri') ? json['uri'] : '';
    unit = json.containsKey('unit') ? json['unit'] : '';
    if (json['sensor_data'] != null) {
      sensorData = <SensorData>[];
      json['sensor_data'].forEach(
        (v) => sensorData!.add(SensorData.fromJson(v)),
      );
    }
  }
}
