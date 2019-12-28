import 'package:basic_engine/app.dart';
import 'package:basic_engine/bundle/piano_boss.dart';
import 'package:basic_engine/common/login_control.dart';
import 'package:basic_engine/constant/icon_constant.dart';
import 'package:basic_engine/home/tabs/person_tab/pages/theme_switcher.dart';
import 'package:basic_engine/home/tabs/person_tab/person_bar.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:flutter/material.dart';

class PersonCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonCenterState();
}

class PersonCenterState extends State<PersonCenter> {
  UserInfo _userInfo;

  @override
  void initState() {
    super.initState();
    this._userInfo = App.getInstance().userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PersonBar(height: 180),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildUserCard(),
                  Column(children: PianoBoss.groupingMenus(context)),
                  _buildAuthButtons(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildUserCard() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        child: Container(
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
//                  child: Image.file(
//                    File('/sdcard/headPhoto.jpeg'),
//                    fit: BoxFit.cover,
//                  ),
                      child: Image.network('https://semantic-ui.com/images/avatar2/large/matthew.png'),
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
                        Text(_userInfo.departmentName ?? '未填写部门信息', style: TextStyle(color: Theme.of(context).hintColor)),
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
                  Text('ID: ${_userInfo.avatar}', style: TextStyle(color: Theme.of(context).hintColor)),
                  Icon(MyIcons.qrCode, color: Theme.of(context).hintColor),
                ],
              ),
            ],
          ),
          alignment: Alignment(0.0, 0.0),
        ),
      ),
    );
  }

  Column _buildAuthButtons() {
    return Column(
      children: <Widget>[
        Container(
          child: ListTile(
            leading: Icon(MyIcons.fill, color: Colors.teal),
            title: Text('主题', style: TextStyle(color: Theme.of(context).hintColor)),
            trailing: Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ThemeSwitcher())),
          ),
          color: Theme.of(context).canvasColor,
        ),
        Container(
          child: ListTile(
            leading: Icon(MyIcons.lock, color: Colors.deepOrange),
            title: Text('修改密码', style: TextStyle(color: Theme.of(context).hintColor)),
            trailing: Icon(Icons.chevron_right),
          ),
          color: Theme.of(context).canvasColor,
        ),
        Divider(height: 1),
        Container(
          child: ListTile(
            title: Center(child: Text('注销登录', style: TextStyle(fontFamily: 'shouji', color: Theme.of(context).hintColor, fontSize: 18))),
            onTap: () => LoginControl.getInstance().logOut(),
          ),
          color: Theme.of(context).canvasColor,
        ),
      ],
    );
  }
}
