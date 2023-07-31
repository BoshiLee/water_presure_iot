import 'package:water_pressure_iot/api_base_helper.dart';
import 'package:water_pressure_iot/models/device.dart';
import 'package:water_pressure_iot/models/login_auth.dart';
import 'package:water_pressure_iot/models/project.dart';

class RegisterProvider {
  static final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Map<String, dynamic>?> registerAccount(
      {required RegisterAuth auth}) async {
    return await _helper.post(
      '/accounts/register',
      data: auth.toJson(),
    );
  }

  Future<Map<String, dynamic>?> registerDevice({
    required Device device,
  }) async {
    return await _helper.post(
      '/devices/register',
      data: device.toJson(),
    );
  }

  Future<Map<String, dynamic>?> registerProject({
    required Project project,
  }) async {
    return await _helper.post(
      '/projects/register',
      data: project.toJson(),
    );
  }
}
