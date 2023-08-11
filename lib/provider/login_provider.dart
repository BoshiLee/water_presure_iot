import 'package:water_pressure_iot/api/api_base_helper.dart';
import 'package:water_pressure_iot/models/login_auth.dart';

class LoginProvider {
  static final ApiBaseHelper _helper = ApiBaseHelper();
  static const String _route = '/accounts/login';

  Future<Map<String, dynamic>?> login({required LoginAuth auth}) async {
    return await _helper.post(
      _route,
      data: auth.toJson(),
    );
  }
}
