import 'package:water_pressure_iot/api_base_helper.dart';
import 'package:water_pressure_iot/models/login_auth.dart';

class LoginProvider {
  static final ApiBaseHelper _helper = ApiBaseHelper();
  static const String _route = '/login';

  Future<Map<String, dynamic>?> login({required LoginAuth auth}) async {
    return await _helper.post(
      _route,
      data: auth.toJson(),
    );
  }

  Future<Map<String, dynamic>?> register({required RegisterAuth auth}) async {
    return await _helper.post(
      '/accounts/register',
      data: auth.toJson(),
    );
  }
}
