enum ApiVersioning { v1, v2 }

extension ApiVersioningExtension on ApiVersioning {
  static ApiVersioning initFrom(String? raw) {
    switch (raw) {
      case 'v1':
        return ApiVersioning.v1;
      case 'v2':
        return ApiVersioning.v2;
      default:
        return ApiVersioning.v2;
    }
  }

  String? get rawValue {
    switch (this) {
      case ApiVersioning.v1:
        return 'v1';
      case ApiVersioning.v2:
        return 'v2';
    }
  }
}
