import 'package:flutter/foundation.dart';
import 'package:water_pressure_iot/api/api_response.dart';
import 'package:water_pressure_iot/api/app_exception.dart';
import 'package:water_pressure_iot/models/account.dart';
import 'package:water_pressure_iot/models/device.dart';
import 'package:water_pressure_iot/models/login_auth.dart';
import 'package:water_pressure_iot/models/project.dart';
import 'package:water_pressure_iot/provider/register_provider.dart';
import 'package:water_pressure_iot/utils/parse_json_helper.dart';

class RegisterRepository {
  final RegisterProvider _regisProvider = RegisterProvider();

  Future<Account?> registerAccount(RegisterAuth auth) async {
    try {
      auth.validate();
    } catch (e) {
      throw BadRequestException(e.toString());
    }
    final response = await _regisProvider.registerAccount(auth: auth);
    if (response == null) throw BadRequestException('註冊失敗，請稍後再試');
    return compute<Map<String, dynamic>, Account?>(
      ParseJsonHelper.parseAccount,
      response,
    );
  }

  Future<ApiResponse> registerProject(Project project) async {
    try {
      project.validate();
    } catch (e) {
      throw BadRequestException(e.toString());
    }
    final response = await _regisProvider.registerProject(project: project);
    if (response == null) throw BadRequestException('註冊失敗，請稍後再試');
    return compute<Map<String, dynamic>, ApiResponse>(
      ParseJsonHelper.parseApiResponse,
      response,
    );
  }

  Future<ApiResponse> registerDevice(Device device) async {
    try {
      device.validate();
    } catch (e) {
      throw BadRequestException(e.toString());
    }
    final response = await _regisProvider.registerDevice(device: device);
    if (response == null) throw BadRequestException('註冊失敗，請稍後再試');
    return compute<Map<String, dynamic>, ApiResponse>(
      ParseJsonHelper.parseApiResponse,
      response,
    );
  }
}
