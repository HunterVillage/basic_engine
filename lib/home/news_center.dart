import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/message/message_listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsCenter extends StatefulWidget {
  final Function onReceive;
  final List<dynamic> unReadMessage;

  NewsCenter({@required this.unReadMessage, @required this.onReceive});

  @override
  State<StatefulWidget> createState() => NewsCenterState();
}

class NewsCenterState extends MessageListener<NewsCenter> {
  List<dynamic> _unReadMessages = [];

  @override
  void initState() {
    super.initState();
    _unReadMessages = widget.unReadMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        MaterialButton(
          color: Colors.cyan,
          onPressed: () {
            socketClient.sendMessage('asdfa');
          },
          child: Text('send message to server and receive somethind', style: TextStyle(color: Colors.white)),
        ),
        MaterialButton(
          color: Colors.yellowAccent,
          onPressed: () {
            socketClient.closeSocket();
          },
          child: Text('close socket'),
        ),
        MaterialButton(
          color: Colors.orange,
          onPressed: () {
            socketClient.connect();
          },
          child: Text('reconnetec', style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }

  @override
  onReceiveMessage(String message) {
    _unReadMessages.add(message);
    global.setUnreadMessage(message);
    widget.onReceive(_unReadMessages.length);
  }
}
