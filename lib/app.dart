import 'package:basic_engine/bundle/bundle.dart';
import 'package:basic_engine/bundle/bundle_boss.dart';
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

  Future init({@required String baseUrl, @required String wsUrl}) async {
    _global = await Global.getInstance();
    _socketClient = await SocketClient.getInstance();
    userInfo = _global.userInfo;
    if (userInfo != null) {
      await _socketClient.connect();
    }
    _global.init(baseUrl: baseUrl, wsUrl: wsUrl);
  }

  void installBundles(String groupName, List<Bundle> bundles) {
    bundles.forEach((bundle) => BundleBoss.register(groupName, bundle));
  }

  Global get global => _global;

  SocketClient get socketClient => _socketClient;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
