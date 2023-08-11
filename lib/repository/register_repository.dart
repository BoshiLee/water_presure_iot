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

  Future<Project> getPreferProject() async {
    final response = await _regisProvider.getPreferProject();
    if (response == null) throw BadRequestException('獲取失敗，請稍後再試');
    if (response['project'] == null) throw BadRequestException('獲取失敗，請稍後再試');
    return compute<Map<String, dynamic>, Project>(
      ParseJsonHelper.parseProject,
      response['project'],
    );
  }

  Future<Project> registerProject(Project project) async {
    try {
      project.validate();
    } catch (e) {
      throw BadRequestException(e.toString());
    }
    final response = await _regisProvider.registerProject(project: project);
    if (response == null) throw BadRequestException('註冊失敗，請稍後再試');
    if (response['project'] == null) throw BadRequestException('註冊失敗，請稍後再試');
    return compute<Map<String, dynamic>, Project>(
      ParseJsonHelper.parseProject,
      response['project'],
    );
  }

  Future<List<Device>> importDevicesFromCHT({
    required int projectId,
  }) async {
    final response = await _regisProvider.importChtDevice(
      projectId: projectId,
    );
    if (response == null) throw BadRequestException('註冊失敗，請稍後再試');
    ApiResponse result = await compute<Map<String, dynamic>, ApiResponse>(
      ParseJsonHelper.parseApiResponse,
      response,
    );
    if (result.json == null) throw BadRequestException('線上無可用的設備');
    if (!result.json!.keys.contains('devices')) {
      throw BadRequestException('線上無可用的設備');
    }
    List<Device> devices = await compute<Map<String, dynamic>, List<Device>>(
      ParseJsonHelper.parseDevices,
      result.json!,
    );
    if (devices.isEmpty) throw BadRequestException('線上無可用的設備');
    return devices;
  }

  Future<List<Device>> registerDevices({
    required int projectId,
    required List<Device> devices,
  }) async {
    for (Device device in devices) {
      try {
        device.validate();
      } catch (e) {
        throw BadRequestException(e.toString());
      }
    }
    final response = await _regisProvider.registerDevices(
      devices: devices,
      projectId: projectId,
    );
    if (response == null) throw BadRequestException('註冊失敗，請稍後再試');
    ApiResponse result = await compute<Map<String, dynamic>, ApiResponse>(
      ParseJsonHelper.parseApiResponse,
      response,
    );
    if (!result.json!.keys.contains('devices')) {
      throw BadRequestException('註冊失敗，請稍後再試');
    }
    return compute<Map<String, dynamic>, List<Device>>(
      ParseJsonHelper.parseDevices,
      response,
    );
  }
}
