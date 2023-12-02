import 'dart:convert';

import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:running_app_flutter/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Key { user, isLogin }

class LocalStorageService extends GetxService {
  SharedPreferences? _sharedPreferences;
  Future<LocalStorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  bool get isLogin {
    final result = _sharedPreferences?.getBool(_Key.isLogin.toString());
    if (result == null) {
      return false;
    }
    return result;
  }

  set isLogin(bool? value) {
    if (value != null) {
      _sharedPreferences?.setBool(_Key.isLogin.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.isLogin.toString());
    }
  }

  User? get user {
    final rawJson = _sharedPreferences?.getString(_Key.user.toString());
    if (rawJson == null) {
      return null;
    }
    Map<String, dynamic> map = jsonDecode(rawJson);
    return User.fromJson(map);
  }

  set user(User? value) {
    if (value != null) {
      _sharedPreferences?.setString(
          _Key.user.toString(), json.encode(value.toJson()));
    } else {
      _sharedPreferences?.remove(_Key.user.toString());
    }
  }
}
