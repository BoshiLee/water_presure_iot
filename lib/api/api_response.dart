class ApiResponse {
  int? statusCode;
  String? message;
  Map<String, dynamic>? json;

  ApiResponse({this.statusCode, this.message});

  ApiResponse.fromJson(dynamic data) {
    if (data == null || data is List) {
      message = '';
      return;
    }
    if (data is String) {
      message = data
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(',', '\n');
      return;
    }
    if (data is Map<String, dynamic>) {
      final Map<String, dynamic> json = Map<String, dynamic>.from(data);
      this.json = json;
      statusCode = json['statusCode'];
      if (json.containsKey('message')) {
        message = json['message'];
      }
      if (json.containsKey('error')) {
        message = json['error'];
      }
    }
  }
}
