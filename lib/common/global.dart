import 'dart:convert';

import 'package:basic_engine/model/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static final String _tokenKey = '0';
  static final String _userInfoKey = '1';
  static final String _baseUrlKey = '2';
  static final String _wsUrlKey = '3';

  static final Global _instance = Global._();
  static SharedPreferences _sp;

  Global._();

  static Future<Global> getInstance() async {
    _sp = await SharedPreferences.getInstance();
    return _instance;
  }

  Future init({@required String baseUrl, @required wsUrl}) async {
    _setBaseUrl(baseUrl);
    _setWsUrl(wsUrl);
  }

  void setToken(token) {
    _sp.setString(_tokenKey, token);
  }

  void clear() {
    _sp.setString(_tokenKey, null);
    _sp.setString(_userInfoKey, null);
  }

  String get token {
    return _sp.getString(_tokenKey) ?? '';
  }

  String get baseUrl {
    return _sp.getString(_baseUrlKey);
  }

  String get wsUrl {
    return _sp.getString(_wsUrlKey);
  }

  void setUserInfo(String userInfo) {
    _sp.setString(_userInfoKey, userInfo);
  }

  String get userInfoStr {
    return _sp.getString(_userInfoKey);
  }

  UserInfo get userInfo {
    if (userInfoStr == null) {
      return null;
    }
    return UserInfo.fromMap(jsonDecode(userInfoStr));
  }

  void _setBaseUrl(String baseUrl) {
    _sp.setString(_baseUrlKey, baseUrl);
  }

  void _setWsUrl(String wsUrl) {
    _sp.setString(_wsUrlKey, wsUrl);
  }
}
