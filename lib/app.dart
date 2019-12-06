import 'package:basic_engine/bundle/bundle.dart';
import 'package:basic_engine/common/global.dart';
import 'package:basic_engine/message/socket_client.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:flutter/material.dart';

class App {
  static App _instance;

  Global _global;
  UserInfo _userInfo;
  SocketClient _socketClient;
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  App._();

  static App getInstance() {
    if (_instance == null) {
      _instance = App._();
    }
    return _instance;
  }

  Future init({@required List<Bundle> bundles, @required String baseUrl, @required String wsUrl}) async {
    _global = await Global.getInstance();
    _socketClient = await SocketClient.getInstance();
    _userInfo = _global.userInfo;
    if (_userInfo != null) {
      await _socketClient.connect();
    }
    _global.init(bundles: bundles, baseUrl: baseUrl, wsUrl: wsUrl);
  }

  Global get global => _global;

  UserInfo get userInfo => _userInfo;

  set userInfo(UserInfo value) {
    _userInfo = value;
  }

  SocketClient get socketClient => _socketClient;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
