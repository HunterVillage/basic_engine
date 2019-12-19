import 'dart:io';

import 'package:basic_engine/app.dart';
import 'package:basic_engine/common/login_control.dart';
import 'package:basic_engine/constant/icon_constant.dart';
import 'package:basic_engine/home/tabs/person_tab/person_bar.dart';
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
    return Stack(
      children: <Widget>[
        PersonBar(height: 180),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50, bottom: 5),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildUserCard(),
                  Container(
                    child: ListTile(
                      leading: Icon(MyIcons.lock, color: Colors.green[400]),
                      title: Text('修改密码', style: TextStyle(color: Colors.black54)),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    color: Colors.white,
                  ),
                  Container(
                    child: ListTile(
                      leading: Icon(MyIcons.setting, color: Colors.deepOrangeAccent[200]),
                      title: Text('设        置', style: TextStyle(color: Colors.black54)),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: ListTile(
                        title: Center(child: Text('注销登录', style: TextStyle(fontFamily: 'shouji', color: Colors.black54, fontSize: 18))),
                        onTap: () => LoginControl.getInstance().logOut(),
                      ),
                      color: Colors.white),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildUserCard() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 70,
                height: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File('/sdcard/headPhoto.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey[200],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      _userInfo.name,
                      style: TextStyle(fontSize: 18, fontFamily: 'pinshang'),
                    ),
                    Text(_userInfo.departmentName ?? '未填写部门信息', style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text('ID: ${_userInfo.avatar}', style: TextStyle(color: Colors.black54)),
              Icon(MyIcons.qrCode, color: Colors.black54),
            ],
          ),
        ],
      ),
      alignment: Alignment(0.0, 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(blurRadius: 1.0, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
