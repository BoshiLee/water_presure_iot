import 'package:water_pressure_iot/constants/app_keys.dart';
import 'package:water_pressure_iot/utils/shared_preferences_utils.dart';

class UserRepository {
  UserRepository._privateConstructor();

  static final UserRepository shared = UserRepository._privateConstructor();

  void deleteJWT() async {
    SharedPreferencesUtils.remove(AppKey.TOKEN);
  }

  set jwt(String? jwt) {
    if (jwt == null) {
      SharedPreferencesUtils.remove(AppKey.TOKEN);
      return;
    }
    SharedPreferencesUtils.putString(AppKey.TOKEN, jwt);
  }

  String? get jwt {
    return SharedPreferencesUtils.getString(AppKey.TOKEN);
  }

  bool get hasJWT {
    return (jwt != null && jwt!.isNotEmpty);
  }

  set email(String? email) {
    if (email == null) {
      SharedPreferencesUtils.remove(AppKey.EMAIL);
      return;
    }
    SharedPreferencesUtils.putString(AppKey.EMAIL, email);
  }

  String? get email {
    return SharedPreferencesUtils.getString(AppKey.EMAIL);
  }

  set rememberMe(bool rememberMe) {
    SharedPreferencesUtils.putBool(AppKey.REMEMBER_ME, rememberMe);
  }

  bool get rememberMe {
    return SharedPreferencesUtils.getBool(AppKey.REMEMBER_ME);
  }
}
