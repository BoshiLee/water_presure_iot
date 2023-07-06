import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';
// SharedPreferences

class SharedPreferencesUtils {
  static SharedPreferencesUtils? _singleton;
  static SharedPreferences? _prefs;
  static final Lock _lock = Lock();

  static Future<SharedPreferencesUtils> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          var singleton = SharedPreferencesUtils._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton!;
  }

  SharedPreferencesUtils._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getString(String key, {String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs!.getString(key) ?? defValue;
  }

  static Future putString(String key, String value) async {
    if (_prefs == null) return null;
    return await _prefs!.setString(key, value);
  }

  static bool getBool(String key, {bool defValue = false}) {
    if (_prefs == null) return defValue;
    return _prefs!.getBool(key) ?? defValue;
  }

  static Future putBool(String key, bool value) async {
    if (_prefs == null) return;
    return await _prefs!.setBool(key, value);
  }

  static Future putListString(String key, List<String> list) async {
    return putString(key, list.join(','));
  }

  static List<String> getListString(String key) {
    final listString = getString(key);
    return listString.split(',');
  }

  static Future<bool> remove(String key) async {
    if (_prefs == null) return false;
    return await _prefs!.remove(key);
  }

  static Future<bool> clear() async {
    if (_prefs == null) return false;
    return _prefs!.clear();
  }

  static bool isInitialized() {
    return _prefs != null;
  }
}
