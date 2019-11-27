import 'package:basic_engine/bundle/bundle.dart';
import 'package:basic_engine/common/global.dart';
import 'package:basic_engine/home/home_page.dart';
import 'package:basic_engine/login/login_page.dart';
import 'package:basic_engine/message/socket_client.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:flutter/material.dart';

Global global;
UserInfo userInfo;
SocketClient socketClient;
BasicApp basicApp;

class BasicApp extends StatefulWidget {
  final String logoPath;
  final String homeTitle;
  final String loginTitle;
  final String loginSubTitle;
  final String loginBackgroundPath;

  const BasicApp({
    Key key,
    @required this.logoPath,
    @required this.homeTitle,
    @required this.loginTitle,
    @required this.loginSubTitle,
    @required this.loginBackgroundPath,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BasicAppState();

  Future preparation({@required List<Bundle> bundles, @required String baseUrl, @required String wsUrl}) async {
    global = await Global.getInstance();
    socketClient = await SocketClient.getInstance();
    userInfo = global.userInfo;
    if (userInfo != null) {
      await socketClient.connect();
    }
    global.init(bundles: bundles, baseUrl: baseUrl, wsUrl: wsUrl);
  }
}

class BasicAppState extends State<BasicApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: userInfo == null
          ? LoginPage(
              backgroundPath: widget.loginBackgroundPath,
              logoPath: widget.logoPath,
              titleLabel: widget.loginTitle,
              welcomeLabel: widget.loginSubTitle,
            )
          : HomePage(title: widget.homeTitle),
    );
  }
}
