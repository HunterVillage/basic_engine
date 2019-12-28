import 'dart:convert';

import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/common/dio_client.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:basic_engine/widgets/tips/tips_tool.dart';

class LoginControl {
  LoginControl._();

  static LoginControl _instance;

  static LoginControl getInstance() {
    if (_instance == null) {
      _instance = LoginControl._();
    }
    return _instance;
  }

  Future<bool> login(String userName, String password) async {
    Map<String, String> params = {'userName': userName, 'password': password, 'serialNo': app.androidInfo.androidId};
    ResponseBody<Map<String, dynamic>> response = await DioClient<Map<String, dynamic>>().post('/login', params: params);
    if (response.success) {
      Map<String, dynamic> userMap = response.data;
      app.global.setUserInfo(jsonEncode(userMap));
      app.userInfo = UserInfo.fromMap(userMap);
      await app.socketClient.connect();
      TipsTool.info(response.message).show();
      return true;
    } else {
      TipsTool.warning(response.message).show();
    }
    return false;
  }

  void logOut() {
    app.global.clear();
    app.messageBox.clear();
    app.userInfo = null;
    app.socketClient.closeSocket();
    app.navigatorKey.currentState.pushNamedAndRemoveUntil('loginPage', (route) => route == null);
  }
}
