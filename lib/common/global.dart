import 'dart:convert';

import 'package:basic_engine/bundle/bundle.dart';
import 'package:basic_engine/bundle/bundle_boss.dart';
import 'package:basic_engine/model/user_info.dart';
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

  String get userInfoStr {
    return _sp.getString(_userInfoKey);
  }

  UserInfo get userInfo {
    if(userInfoStr == null){
      return null;
    }
    return UserInfo.fromMap(jsonDecode(userInfoStr));
  }

  void setUnreadMessage(String message) {
    String avatar = this.userInfo.avatar;
    Map<String, List<String>> unreadMessageMap;
    String unreadMessageStr = this.unreadMessageStr;
    if (unreadMessageStr == null) {
      unreadMessageMap = {};
    } else {
      unreadMessageMap = jsonDecode(unreadMessageStr);
    }
    List<String> ownMessages = unreadMessageMap[avatar];
    if (ownMessages == null) {
      ownMessages = [];
    }
    ownMessages.add(message);
    unreadMessageMap[avatar] = ownMessages;
    _sp.setString(_unreadMessageKey, jsonEncode(unreadMessageMap));
  }

  String get unreadMessageStr {
    return _sp.get(_unreadMessageKey);
  }

  List<String> get unreadMessage {
    String avatar = this.userInfo.avatar;
    Map<String, List<String>> unreadMessageMap;
    String unreadMessageStr = this.unreadMessageStr;
    if (unreadMessageStr == null) {
      unreadMessageMap = {};
    } else {
      unreadMessageMap = jsonDecode(unreadMessageStr);
    }
    return unreadMessageMap[avatar];
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
