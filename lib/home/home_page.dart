import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/home/menu_center.dart';
import 'package:basic_engine/home/news_center.dart';
import 'package:basic_engine/home/person_center.dart';
import 'package:basic_engine/home/widgets/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  int _newsNum;
  List<dynamic> _unReadMessages = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _unReadMessages = global.unreadMessage;
    _newsNum = _unReadMessages.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            MenuCenter(),
            NewsCenter(
              unReadMessage: _unReadMessages,
              onReceive: (value) {
                this.setState(() => _newsNum = value);
              },
            ),
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
