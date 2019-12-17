import 'dart:convert';

import 'package:basic_engine/message/message_body.dart';
import 'package:basic_engine/message/socket_client.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final PublishSubject<List<MessageBody>> globalMessageSubject = PublishSubject<List<MessageBody>>();

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
    socketMessageSubject.stream.listen((messageBody) => pushUnreadMessage(messageBody));
  }

  void setToken(token) {
    _sp.setString(_tokenKey, token);
  }

  void clean() {
    _sp.setString(_tokenKey, null);
    _sp.setString(_userInfoKey, null);
    _sp.setString(_unreadMessageKey, null);
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

  void pushUnreadMessage(MessageBody messageBody) {
    String avatar = this.userInfo.avatar;
    Map<String, dynamic> allMessage = allUnreadMessage;

    List<dynamic> ownMessages = allMessage[avatar];
    if (ownMessages == null) ownMessages = [];
    ownMessages.add(jsonEncode(messageBody.toMap()));
    allMessage[avatar] = ownMessages;
    _sp.setString(_unreadMessageKey, jsonEncode(allMessage));
    globalMessageSubject.add(ownUnreadMessage);
  }

  MessageBody popUnreadMessage(String uuid) {
    String avatar = this.userInfo.avatar;
    Map<String, dynamic> allMessage = allUnreadMessage;
    List<dynamic> ownMessages = allMessage[avatar];
    if (ownMessages != null) {
      String popMessageStr = ownMessages.singleWhere((item) => jsonDecode(item)['uuid'] == uuid);
      ownMessages.remove(popMessageStr);
      _sp.setString(_unreadMessageKey, jsonEncode(allMessage));
      globalMessageSubject.add(ownUnreadMessage);
      return MessageBody.fromMap(jsonDecode(popMessageStr));
    } else {
      return null;
    }
  }

  List<MessageBody> get ownUnreadMessage {
    String avatar = this.userInfo.avatar;
    List messageList = allUnreadMessage[avatar];
    return messageList != null && messageList.length > 0 ? MessageBody.allFromMap(messageList.map((item) => jsonDecode(item)).toList()) : [];
  }

  Map<String, dynamic> get allUnreadMessage {
    String unreadMessageStr = _sp.get(_unreadMessageKey);
    return unreadMessageStr != null ? jsonDecode(unreadMessageStr) : {};
  }

  void _setBaseUrl(String baseUrl) {
    _sp.setString(_baseUrlKey, baseUrl);
  }

  void _setWsUrl(String wsUrl) {
    _sp.setString(_wsUrlKey, wsUrl);
  }
}
