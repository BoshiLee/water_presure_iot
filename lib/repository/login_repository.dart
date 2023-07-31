import 'package:flutter/foundation.dart';
import 'package:water_pressure_iot/api/app_exception.dart';
import 'package:water_pressure_iot/models/account.dart';
import 'package:water_pressure_iot/models/login_auth.dart';
import 'package:water_pressure_iot/provider/login_provider.dart';
import 'package:water_pressure_iot/utils/parse_json_helper.dart';

class LoginRepository {
  final LoginProvider _loginProvider = LoginProvider();

  Future<Account?> login(LoginAuth auth) async {
    try {
      auth.validate();
    } catch (e) {
      throw BadRequestException(e.toString());
    }
    final response = await _loginProvider.login(auth: auth);
    if (response == null) throw BadRequestException('無法取得帳號資訊');
    return compute<Map<String, dynamic>, Account?>(
      ParseJsonHelper.parseAccount,
      response,
    );
  }

  Future<Account?> register(RegisterAuth auth) async {
    try {
      auth.validate();
    } catch (e) {
      throw BadRequestException(e.toString());
    }
    final response = await _loginProvider.register(auth: auth);
    if (response == null) throw BadRequestException('註冊失敗，請稍後再試');
    return compute<Map<String, dynamic>, Account?>(
      ParseJsonHelper.parseAccount,
      response,
    );
  }
}
