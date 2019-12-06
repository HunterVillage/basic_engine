import 'package:basic_engine/app.dart';
import 'package:basic_engine/home/home_page.dart';
import 'package:basic_engine/login/login_page.dart';
import 'package:flutter/material.dart';

App app = App.getInstance();

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
}

class BasicAppState extends State<BasicApp> {
  var _routers;
  Widget _loginPage;
  Widget _homePage;

  @override
  void initState() {
    super.initState();
    _loginPage = LoginPage(backgroundPath: widget.loginBackgroundPath, logoPath: widget.logoPath, titleLabel: widget.loginTitle, welcomeLabel: widget.loginSubTitle);
    _homePage = HomePage(title: widget.homeTitle);
    _routers = {'loginPage': (_) => _loginPage, 'homePage': (_) => _homePage};
  }

  @override
  Widget build(BuildContext context) {
    Widget _currentPage = app.userInfo == null ? _loginPage : _homePage;
    return MaterialApp(
      navigatorKey: app.navigatorKey,
      routes: _routers,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _currentPage,
    );
  }
}
