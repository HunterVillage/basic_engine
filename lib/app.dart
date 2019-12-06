import 'package:basic_engine/bundle/bundle.dart';
import 'package:basic_engine/common/global.dart';
import 'package:basic_engine/message/socket_client.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:flutter/material.dart';

class App {
  static App _instance;

  Global _global;
  UserInfo userInfo;
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
    userInfo = _global.userInfo;
    if (userInfo != null) {
      await _socketClient.connect();
    }
    _global.init(bundles: bundles, baseUrl: baseUrl, wsUrl: wsUrl);
  }

  Global get global => _global;

  SocketClient get socketClient => _socketClient;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
