class Device {
  String? name;
  String? description;
  String? uri;
  String? type;
  String? deviceKey;
  String? deviceNumber;
  int? projectId;

  Device(
      {name,
      description,
      uri,
      type,
      deviceKey,
      deviceNumber,
      accountId,
      projectId});

  Device.fromJson(Map<String, dynamic> json) {
    name = json.containsKey('name') ? json['name'] : null;
    description = json.containsKey('description') ? json['description'] : null;
    uri = json.containsKey('url') ? json['uri'] : null;
    type = json.containsKey('type') ? json['type'] : null;
    deviceKey = json.containsKey('device_key') ? json['device_key'] : null;
    deviceNumber =
        json.containsKey('device_number') ? json['device_number'] : null;
    projectId = json.containsKey('project_id') ? json['project_id'] : null;
  }

  void validate() {
    if (name == null || name!.isEmpty) throw Exception('請輸入裝置名稱');
    if (description == null || description!.isEmpty) throw Exception('請輸入裝置描述');
    if (uri == null || uri!.isEmpty) throw Exception('請輸入裝置網址');
    if (deviceKey == null || deviceKey!.isEmpty) throw Exception('請輸入裝置金鑰');
    if (deviceNumber == null || deviceNumber!.isEmpty) {
      throw Exception('請輸入裝置編號');
    }
    if (projectId == null) throw Exception('請選擇專案');
  }

  Device copyWith({
    String? name,
    String? description,
    String? uri,
    String? type,
    String? deviceKey,
    String? deviceNumber,
    int? projectId,
  }) {
    return Device(
      name: name ?? this.name,
      description: description ?? this.description,
      uri: uri ?? this.uri,
      type: type ?? this.type,
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
    data['type'] = type;
    data['device_key'] = deviceKey;
    data['device_number'] = deviceNumber;
    data['project_id'] = projectId;
    return data;
  }
}
