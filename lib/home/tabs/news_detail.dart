import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/message/message_body.dart';
import 'package:basic_engine/message/notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewsDetailState();
}

class NewsDetailState extends State<NewsDetail> {
  MessageBody _messageBody;
  String _messageId;

  @override
  void initState() {
    super.initState();
    notifierSubject.stream.listen((id) {
      if (_messageId == null || _messageId != id) {
        if (mounted) {
          _messageId = id;
          MessageBody messageBody = app.global.popUnreadMessage(id);
          this.setState(() => _messageBody = messageBody);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('消息详情')),
      body: _messageBody != null
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(_messageBody.title),
                  Divider(),
                  Text(_messageBody.content),
                ],
              ),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
