import 'package:basic_engine/app.dart';
import 'package:basic_engine/home/home_page.dart';
import 'package:basic_engine/login/login_page.dart';
import 'package:flutter/material.dart';

App app = App.getInstance();

class BasicApp extends StatefulWidget {
  final ThemeData theme;
  final String appTitle;
  final String homeTitle;
  final Map<String, WidgetBuilder> routers;
  final Widget loginPage;

  const BasicApp({
    Key key,
    this.theme,
    this.appTitle = '',
    @required this.homeTitle,
    this.routers = const <String, WidgetBuilder>{},
    this.loginPage,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BasicAppState();
}

class BasicAppState extends State<BasicApp> {
  Map<String, WidgetBuilder> _routers;
  Widget _loginPage;
  Widget _homePage;
  ThemeData _themeData;

  @override
  void initState() {
    super.initState();
    this._controlTheme();
    this._controlLoginPage();
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
      theme: _themeData,
      home: _currentPage,
    );
  }

  _controlTheme() {
    if (widget.theme == null) {
      _themeData = ThemeData(
        backgroundColor: Colors.grey[100],
        primaryColorLight: Colors.black54,
        cardColor: Colors.white,
      );
    } else {
      _themeData = widget.theme;
    }
  }

  _controlLoginPage() {
    if (widget.loginPage == null) {
      _loginPage = LoginPage(
          backgroundPath: 'assets/images/background.png',
          logoPath: 'assets/images/logo.png',
          titleLabel: 'Basic Engine',
          welcomeLabel: 'Albert Einstein: Logic will get you from A to B. Imagination will take you everywhere.');
    } else {
      _loginPage = widget.loginPage;
    }
  }
}
