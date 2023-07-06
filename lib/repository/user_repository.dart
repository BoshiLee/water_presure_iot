import 'package:water_pressure_iot/constants/app_keys.dart';
import 'package:water_pressure_iot/utils/shared_preferences_utils.dart';

class UserRepository {
  UserRepository._privateConstructor();

  static final UserRepository shared = UserRepository._privateConstructor();

  void deleteJWT() async {
    SharedPreferencesUtils.remove(AppKey.TOKEN);
  }

  set jwt(String jwt) {
    SharedPreferencesUtils.putString(AppKey.TOKEN, jwt);
  }

  String get jwt {
    return SharedPreferencesUtils.getString(AppKey.TOKEN);
  }

  bool get hasJWT {
    return (this.jwt.isNotEmpty);
  }
}