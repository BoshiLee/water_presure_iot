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

  Future<Map<String, dynamic>?> registerDevices({
    required int projectId,
    required List<Device> devices,
  }) async {
    Map<String, dynamic> data = {
      'devices': devices.map((e) => e.toJson()).toList(),
    };
    return await _helper.post(
      '/projects/$projectId/devices/register/multiple',
      data: data,
    );
  }

  Future<Map<String, dynamic>?> importChtDevice({
    required int projectId,
  }) async {
    return await _helper.get(
      '/projects/$projectId/devices/nbiot',
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
