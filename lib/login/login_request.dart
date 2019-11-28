import 'dart:convert';

import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/common/dio_client.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginRequest {
  static Future<bool> login(BuildContext context, String userName, String password) async {
    Map<String, String> params = {'userName': userName, 'password': password};
    ResponseBody<Map<String, dynamic>> response = await DioClient<Map<String, dynamic>>().post(context, '/login', params: params);
    if (response == null) return false;
    Map<String, dynamic> userMap = response.data;
    global.setUserInfo(jsonEncode(userMap));
    userInfo = UserInfo.fromMap(userMap);
    return true;
  }

  static void logOut(BuildContext context) {
    global.setUserInfo(null);
    userInfo = null;
    socketClient.closeSocket();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => basicApp), (route) => route == null);
  }
}
