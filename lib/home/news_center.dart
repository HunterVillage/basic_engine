import 'package:basic_engine/basic_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsCenter extends StatefulWidget {
  final List<dynamic> unReadMessage;

  NewsCenter({@required this.unReadMessage});

  @override
  State<StatefulWidget> createState() => NewsCenterState();
}

class NewsCenterState extends State<NewsCenter> {
  List<dynamic> _unReadMessages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        MaterialButton(
          color: Colors.cyan,
          onPressed: () {
            app.socketClient.sendMessage('你好');
          },
          child: Text('send message to server and receive somethind', style: TextStyle(color: Colors.white)),
        ),
        MaterialButton(
          color: Colors.yellowAccent,
          onPressed: () {
            app.socketClient.closeSocket();
          },
          child: Text('close socket'),
        ),
        MaterialButton(
          color: Colors.orange,
          onPressed: () {
            app.socketClient.connect();
          },
          child: Text('reconnetec', style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
