import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/message/socket_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewsCenterState();
}

class NewsCenterState extends State<NewsCenter> {
  List<dynamic> _unReadMessages = [];

  @override
  void initState() {
    super.initState();
    _unReadMessages = app.global.unreadMessage;
    messageSubject.stream.listen((messageBody) => this.setState(() => _unReadMessages = app.global.unreadMessage));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text('消息条数:${_unReadMessages.length}'),
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
