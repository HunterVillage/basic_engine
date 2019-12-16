import 'package:basic_engine/app.dart';
import 'package:basic_engine/common/login_control.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:flutter/material.dart';

class PersonCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonCenterState();
}

class PersonCenterState extends State<PersonCenter> {
  UserInfo _userInfo;
  String _subName;

  @override
  void initState() {
    super.initState();
    this._userInfo = App.getInstance().userInfo;
    _subName = _userInfo.name.substring(_userInfo.name.length - 2, _userInfo.name.length);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text(_subName, style: TextStyle(color: Colors.white)),
            ),
          ),
          Center(
            child: MaterialButton(
              onPressed: () => LoginControl.getInstance().logOut(),
              child: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
