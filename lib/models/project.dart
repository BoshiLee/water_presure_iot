class Project {
  String? name;
  String? description;
  String? applicationField;
  String? projectCode;
  String? projectKey;

  Project({
    name,
    description,
    applicationField,
    projectCode,
    projectKey,
  });

  void validate() {
    if (name == null || name!.isEmpty) throw Exception('請輸入專案名稱');
    if (description == null || description!.isEmpty) throw Exception('請輸入專案描述');
    if (projectCode == null || projectCode!.isEmpty) throw Exception('請輸入專案代碼');
    if (projectKey == null || projectKey!.isEmpty) throw Exception('請輸入專案金鑰');
  }

  Project.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    applicationField = json['application_field'];
    projectCode = json['project_code'];
    projectKey = json['project_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['application_field'] = applicationField;
    data['project_code'] = projectCode;
    data['project_key'] = projectKey;
    return data;
  }
}
