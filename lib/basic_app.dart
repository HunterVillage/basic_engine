import 'package:basic_engine/app.dart';
import 'package:basic_engine/home/home_page.dart';
import 'package:basic_engine/login/login_page.dart';
import 'package:flutter/material.dart';

App app = App.getInstance();

class BasicApp extends StatefulWidget {
  final ThemeData theme;
  final String logoPath;
  final String appTitle;
  final String homeTitle;
  final String loginTitle;
  final String loginSubTitle;
  final String loginBackgroundPath;
  final Map<String, WidgetBuilder> routers;

  const BasicApp({
    Key key,
    this.theme,
    @required this.logoPath,
    this.appTitle = '',
    @required this.homeTitle,
    @required this.loginTitle,
    @required this.loginSubTitle,
    @required this.loginBackgroundPath,
    this.routers = const <String, WidgetBuilder>{},
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BasicAppState();
}

class BasicAppState extends State<BasicApp> {
  Map<String, WidgetBuilder> _routers;
  Widget _loginPage;
  Widget _homePage;

  @override
  void initState() {
    super.initState();
    _loginPage = LoginPage(backgroundPath: widget.loginBackgroundPath, logoPath: widget.logoPath, titleLabel: widget.loginTitle, welcomeLabel: widget.loginSubTitle);
    _homePage = HomePage(title: widget.homeTitle);
    _routers = {'loginPage': (_) => _loginPage, 'homePage': (_) => _homePage};
    _routers.addAll(widget.routers);
  }

  @override
  Widget build(BuildContext context) {
    Widget _currentPage = app.userInfo == null ? _loginPage : _homePage;
    return MaterialApp(
      navigatorKey: app.navigatorKey,
      routes: _routers,
      title: widget.appTitle,
      theme: widget.theme,
      home: _currentPage,
    );
  }
}
