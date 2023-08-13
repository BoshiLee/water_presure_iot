class Device {
  String? name;
  String? description;
  String? uri;
  String? deviceType;
  String? deviceKey;
  String? deviceNumber;
  int? projectId;

  Device({
    this.name,
    this.description,
    this.uri,
    this.deviceType,
    this.deviceKey,
    this.deviceNumber,
    this.projectId,
  });

  Device.fromJson(Map<String, dynamic> json) {
    name = json.containsKey('name') ? json['name'] : null;
    description = json.containsKey('description') ? json['description'] : null;
    uri = json.containsKey('uri') ? json['uri'] : null;
    deviceType = json.containsKey('device_type') ? json['device_type'] : null;
    deviceKey = json.containsKey('device_key') ? json['device_key'] : null;
    deviceNumber =
        json.containsKey('device_number') ? json['device_number'] : null;
    projectId = json.containsKey('project_id') ? json['project_id'] : null;
  }

  void validate() {
    if (name == null || name!.isEmpty) throw Exception('請輸入裝置名稱');
    if (deviceType == null || deviceType!.isEmpty) Exception('請輸入裝置類型');
    if (deviceKey == null || deviceKey!.isEmpty) throw Exception('請輸入裝置金鑰');
  }

  Device copyWith({
    String? name,
    String? description,
    String? uri,
    String? deviceType,
    String? deviceKey,
    String? deviceNumber,
    int? projectId,
  }) {
    return Device(
      name: name ?? this.name,
      description: description ?? this.description,
      uri: uri ?? this.uri,
      deviceType: deviceType ?? this.deviceType,
      deviceKey: deviceKey ?? this.deviceKey,
      deviceNumber: deviceNumber ?? this.deviceNumber,
      projectId: projectId ?? this.projectId,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['uri'] = uri;
    data['type'] = deviceType;
    data['device_key'] = deviceKey;
    data['device_number'] = deviceNumber;
    data['project_id'] = projectId;
    return data;
  }
}
