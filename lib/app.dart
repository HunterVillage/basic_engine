import 'package:basic_engine/bundle/bundle.dart';
import 'package:basic_engine/bundle/bundle_boss.dart';
import 'package:basic_engine/bundle/piano.dart';
import 'package:basic_engine/bundle/piano_boss.dart';
import 'package:basic_engine/common/global.dart';
import 'package:basic_engine/common/message_box.dart';
import 'package:basic_engine/message/notifier.dart';
import 'package:basic_engine/message/socket_client.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

const bool inProduction = const bool.fromEnvironment("dart.vm.product");

class App {
  static App _instance;

  Global _global;
  UserInfo userInfo;
  SocketClient _socketClient;
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  Notifier _notifier;
  MessageBox _messageBox;
  AndroidDeviceInfo _androidInfo;
  Map<String, WidgetBuilder> _routers = {};

  App._();

  static App getInstance() {
    WidgetsFlutterBinding.ensureInitialized();
    if (_instance == null) {
      _instance = App._();
    }
    return _instance;
  }

  Future init({@required String baseUrl, @required String wsUrl}) async {
    _global = await Global.getInstance();
    _socketClient = await SocketClient.getInstance();
    _androidInfo = await DeviceInfoPlugin().androidInfo;
    _notifier = Notifier.getInstance();
    _messageBox = MessageBox.getInstance();
    userInfo = _global.userInfo;
    if (userInfo != null) {
      await _socketClient.connect();
    }
    _global.init(baseUrl: baseUrl, wsUrl: wsUrl);
    _notifier.init();
  }

  void installBundles(String groupName, List<Bundle> bundles) {
    bundles.forEach((bundle) {
      BundleBoss.register(groupName, bundle);
      _routers.putIfAbsent(bundle.id, () => (_) => bundle);
    });
  }

  void installPianos(String groupName, List<Piano> pianos) {
    pianos.forEach((piano) {
      PianoBoss.register(groupName, piano);
      _routers.putIfAbsent(piano.id, () => (_) => piano);
    });
  }

  Global get global => _global;

  SocketClient get socketClient => _socketClient;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Notifier get notifier => _notifier;

  MessageBox get messageBox => _messageBox;

  AndroidDeviceInfo get androidInfo => _androidInfo;

  Map<String, WidgetBuilder> get routers => _routers;
}