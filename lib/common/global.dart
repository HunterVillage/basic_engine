import 'package:basic_engine/bundle/bundle.dart';
import 'package:basic_engine/bundle/bundle_boss.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static final String _token = '0';
  static final String _userInfo = '1';
  static final String _baseUrl = '2';

  static final Global _instance = Global._();
  static SharedPreferences _sp;

  Global._();

  static Future<Global> getInstance() async {
    _sp = await SharedPreferences.getInstance();
    return _instance;
  }

  Future init({@required List<Bundle> bundles, @required String baseUrl}) async {
    _installBundles(bundles);
    _setBaseUrl(baseUrl);
  }

  void setToken(token) {
    _sp.setString(_token, token);
  }

  String get token {
    return _sp.getString(_token) ?? '';
  }

  String get baseUrl {
    return _sp.getString(_baseUrl);
  }

  void setUserInfo(String userInfo) {
    _sp.setString(_userInfo, userInfo);
  }

  String get userInfo {
    return _sp.getString(_userInfo);
  }

  void _installBundles(List<Bundle> bundles) {
    bundles.forEach((bundle) => BundleBoss.register(bundle));
  }

  void _setBaseUrl(String baseUrl) {
    _sp.setString(baseUrl, baseUrl);
  }
}
