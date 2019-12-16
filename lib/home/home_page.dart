import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/home/tabs/menu_center.dart';
import 'package:basic_engine/home/tabs/news_center.dart';
import 'package:basic_engine/home/tabs/news_detail.dart';
import 'package:basic_engine/home/tabs/person_center.dart';
import 'package:basic_engine/home/widgets/bottom_navy_bar.dart';
import 'package:basic_engine/message/message_body.dart';
import 'package:basic_engine/message/notifier.dart';
import 'package:basic_engine/message/socket_client.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _currentIndex = 0;
  int _newsNum;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _newsNum = app.global.unreadMessage.length;

    messageSubject.stream.listen((messageBody) => this.setState(() => _newsNum = app.global.unreadMessage.length));

    notifierSubject.stream.listen((id) {
      this.setState(() => _currentIndex = 1);
      MessageBody messageBody = app.global.unreadMessage.singleWhere((item) => item.id == id);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsDetail(messageBody.title, messageBody.content)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: Text(widget.title)),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            MenuCenter(),
            NewsCenter(),
            PersonCenter(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: Text('Menus'), icon: Icon(Icons.apps)),
          BottomNavyBarItem(title: Text('Messages'), icon: Icon(Icons.message), news: _newsNum),
          BottomNavyBarItem(title: Text('Person'), icon: Icon(Icons.person_pin)),
        ],
      ),
    );
  }
}
