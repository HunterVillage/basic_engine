import 'dart:convert';

import 'package:basic_engine/message/message_body.dart';
import 'package:basic_engine/message/socket_client.dart';
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

  Future init({@required String baseUrl, @required wsUrl}) async {
    _setBaseUrl(baseUrl);
    _setWsUrl(wsUrl);

    messageSubject.stream.listen((messageBody) => setUnreadMessage(messageBody));
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
    if (userInfoStr == null) {
      return null;
    }
    return UserInfo.fromMap(jsonDecode(userInfoStr));
  }

  void setUnreadMessage(MessageBody messageBody) {
    String avatar = this.userInfo.avatar;
    Map<String, dynamic> unreadMessageMap;
    String unreadMessageStr = _sp.get(_unreadMessageKey);
    if (unreadMessageStr == null) {
      unreadMessageMap = {};
    } else {
      unreadMessageMap = jsonDecode(unreadMessageStr);
    }
    List<dynamic> ownMessages = unreadMessageMap[avatar];
    if (ownMessages == null) {
      ownMessages = [];
    }
    ownMessages.add(jsonEncode(messageBody.toMap()));
    unreadMessageMap[avatar] = ownMessages;
    _sp.setString(_unreadMessageKey, jsonEncode(unreadMessageMap));
  }

  List<MessageBody> get unreadMessage {
    String avatar = this.userInfo.avatar;
    Map<String, dynamic> unreadMessageMap;
    String unreadMessageStr = _sp.get(_unreadMessageKey);
    if (unreadMessageStr != null) {
      unreadMessageMap = jsonDecode(unreadMessageStr);
      List messageList = unreadMessageMap[avatar];
      return messageList != null && messageList.length > 0 ? MessageBody.allFromMap(messageList.map((item) => jsonDecode(item)).toList()) : [];
    } else {
      return [];
    }
  }

  void _setBaseUrl(String baseUrl) {
    _sp.setString(_baseUrlKey, baseUrl);
  }

  void _setWsUrl(String wsUrl) {
    _sp.setString(_wsUrlKey, wsUrl);
  }
}
