import 'dart:convert';

import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/common/dio_client.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:flutter/cupertino.dart';

class LoginRequest {
  static Future<bool> login(BuildContext context, String userName, String password) async {
    Map<String, String> params = {'userName': userName, 'password': password};
    String uStr = await DioClient<String>().post(context, '/login', params: params);
    if (uStr == null) return false;
    global.setUserInfo(uStr);
    userInfo = UserInfo.fromMap(jsonDecode(uStr));
    return true;
  }

  static void logOut() {
    global.setUserInfo(null);
    userInfo = null;
    socketClient.closeSocket();
  }
}
