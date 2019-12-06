import 'dart:convert';

import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/common/dio_client.dart';
import 'package:basic_engine/login/utility/color_utility.dart';
import 'package:basic_engine/login/utility/login_constant.dart';
import 'package:basic_engine/login/widgets/forward_button.dart';
import 'package:basic_engine/login/widgets/header_text.dart';
import 'package:basic_engine/login/widgets/login_top_bar.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:basic_engine/widgets/tip_bar.dart';
import 'package:flutter/material.dart';

import 'login_animation.dart';
import 'login_request.dart';

class LoginPage extends StatefulWidget {
  final String backgroundPath;
  final String logoPath;
  final String titleLabel;
  final String welcomeLabel;

  const LoginPage({
    Key key,
    @required this.backgroundPath,
    @required this.logoPath,
    @required this.titleLabel,
    @required this.welcomeLabel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  LoginEnterAnimation enterAnimation;
  AnimationController animationController;

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _userName;
  String _password;

  @override
  initState() {
    super.initState();
    animationController = new AnimationController(duration: const Duration(seconds: 1), vsync: this)
      ..addListener(() {
        setState(() {});
      });
    enterAnimation = new LoginEnterAnimation(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Color(getColorHexFromStr(COLOR_LOGIN)),
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              _transTopView(size, textTheme),
              _transBottomView(size, textTheme, context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildForm(Size size, TextTheme textTheme) {
    return Padding(
        padding: EdgeInsets.only(top: size.height * 0.3, left: 24, right: 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: _buildTextFormUsername(textTheme),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 12),
                  child: Container(
                    color: Colors.grey,
                    height: 1,
                    width: enterAnimation.dividerScale.value * size.width,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: _buildTextFormPassword(textTheme),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildTextFormUsername(TextTheme textTheme) {
    return FadeTransition(
      opacity: enterAnimation.userNameOpacity,
      child: TextFormField(
        style: textTheme.title.copyWith(color: Colors.black87, letterSpacing: 1.2),
        decoration: new InputDecoration(
          border: InputBorder.none,
          hintText: USER_NAME_HINT,
          hintStyle: textTheme.subhead.copyWith(color: Colors.grey),
          icon: Icon(Icons.person, color: Colors.black87),
          contentPadding: EdgeInsets.zero,
        ),
        keyboardType: TextInputType.text,
        controller: _userNameController,
        validator: (val) => val.length == 0 ? USER_NAME_VALIDATION_EMPTY : null,
        onSaved: (val) => _userName = val,
      ),
    );
  }

  Widget _buildTextFormPassword(TextTheme textTheme) {
    return FadeTransition(
      opacity: enterAnimation.passowrdOpacity,
      child: TextFormField(
        style: textTheme.title.copyWith(color: Colors.black87, letterSpacing: 1.2),
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: PASSWORD_HINT,
            hintStyle: textTheme.subhead.copyWith(color: Colors.grey),
            contentPadding: EdgeInsets.zero,
            icon: Icon(Icons.lock, color: Colors.black87)),
        keyboardType: TextInputType.text,
        controller: _passwordController,
        obscureText: true,
        validator: (val) => val.length == 0 ? USER_NAME_VALIDATION_EMPTY : null,
        onSaved: (val) => _password = val,
      ),
    );
  }

  Widget _buildSignButton(context) {
    return Transform(
      transform: Matrix4.translationValues(enterAnimation.translation.value * 200, enterAnimation.translation.value * 20, 0.0),
      child: ForwardButton(
        onPressed: () async {
          bool validate = _formKey.currentState.validate();
          if (validate) {
            _formKey.currentState.save();
            ResponseBody<Map<String, dynamic>> response = await LoginRequest.getInstance().login(context, _userName, _password);
            if (response != null) {
              if (response.success) {
                Map<String, dynamic> userMap = response.data;
                app.global.setUserInfo(jsonEncode(userMap));
                app.userInfo = UserInfo.fromMap(userMap);
                await animationController.reverse();
                await app.socketClient.connect();
                app.navigatorKey.currentState.pushNamedAndRemoveUntil('homePage', (route) => route == null);
              } else {
                Scaffold.of(context).showSnackBar(TipBar.build(response.message,color: Colors.deepOrange));
              }
            } else {
              Scaffold.of(context).showSnackBar(TipBar.build('网络异常'));
            }
          }
        },
        label: BUTTON_SIGN_IN,
      ),
    );
  }

  Widget _transTopView(Size size, TextTheme textTheme) {
    return Transform(
      transform: Matrix4.translationValues(0.0, -enterAnimation.Ytranslation.value * size.height, 0.0),
      child: LoginTopBar(
          child: Container(
        height: size.height * 0.67,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: new AssetImage(widget.backgroundPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(-enterAnimation.Xtranslation.value * size.width, 0.0, 0.0),
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.15, left: 24, right: 24),
                child: HeaderText(text: widget.titleLabel, imagePath: widget.logoPath),
              ),
            ),
            _buildForm(size, textTheme),
          ],
        ),
      )),
    );
  }

  Widget _transBottomView(Size size, TextTheme textTheme,context) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.72),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FadeTransition(
              opacity: enterAnimation.titleLabelOpacity,
              child: Text(
                widget.welcomeLabel,
                style: textTheme.title.copyWith(fontFamily: 'shouji', color: Colors.black87, fontWeight: FontWeight.normal, wordSpacing: 1.2, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            _buildSignButton(context),
          ],
        ),
      ),
    );
  }
}
