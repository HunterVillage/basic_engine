import 'dart:convert';

import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/common/dio_client.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginRequest {
  LoginRequest._();

  static LoginRequest _instance;

  static LoginRequest getInstance() {
    if (_instance == null) {
      _instance = LoginRequest._();
    }
    return _instance;
  }

  Future<bool> login(BuildContext context, String userName, String password) async {
    Map<String, String> params = {'userName': userName, 'password': password};
    ResponseBody<Map<String, dynamic>> response = await DioClient<Map<String, dynamic>>().post(context, '/login', params: params);
    if (response == null) return false;
    Map<String, dynamic> userMap = response.data;
    app.global.setUserInfo(jsonEncode(userMap));
    app.userInfo = UserInfo.fromMap(userMap);
    return true;
  }

  void logOut() {
    app.global.setUserInfo(null);
    app.userInfo = null;
    app.socketClient.closeSocket();
    app.navigatorKey.currentState.pushNamedAndRemoveUntil('loginPage', (route) => route == null);
  }
}
