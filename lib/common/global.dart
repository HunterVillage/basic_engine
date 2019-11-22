import 'package:basic_engine/bundle/bundle.dart';
import 'package:basic_engine/bundle/bundle_boss.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static final String _tokenKey = '0';
  static final String _userInfoKey = '1';
  static final String _baseUrlKey = '2';
  static final String _wsUrlKey = '3';
  static final String _unreadMessageKey = '4';

  static final Global _instance = Global._();
  static SharedPreferences _sp;

  Global._();

  static Future<Global> getInstance() async {
    _sp = await SharedPreferences.getInstance();
    return _instance;
  }

  Future init({@required List<Bundle> bundles, @required String baseUrl, @required wsUrl}) async {
    _installBundles(bundles);
    _setBaseUrl(baseUrl);
    _setWsUrl(wsUrl);
  }

  void setToken(token) {
    _sp.setString(_tokenKey, token);
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

  String get userInfo {
    return _sp.getString(_userInfoKey);
  }

  void setUnreadMessage(String message) {
    _sp.setString(_unreadMessageKey, message);
  }

  String get unreadMessage {
    return _sp.get(_unreadMessageKey);
  }

  void _installBundles(List<Bundle> bundles) {
    bundles.forEach((bundle) => BundleBoss.register(bundle));
  }

  void _setBaseUrl(String baseUrl) {
    _sp.setString(_baseUrlKey, baseUrl);
  }

  void _setWsUrl(String wsUrl) {
    _sp.setString(_wsUrlKey, wsUrl);
  }
}
