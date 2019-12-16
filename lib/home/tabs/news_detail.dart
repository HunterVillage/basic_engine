import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/message/message_body.dart';
import 'package:basic_engine/message/notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  final MessageBody messageBody;

  NewsDetail(this.messageBody);

  @override
  State<StatefulWidget> createState() => NewsDetailState();
}

class NewsDetailState extends State<NewsDetail> {
  MessageBody _messageBody;

  @override
  void initState() {
    super.initState();
    _messageBody = widget.messageBody;
    notifierSubject.stream.listen((id) {
      MessageBody messageBody = app.global.unreadMessage.singleWhere((item) => item.id == id);
      this.setState(() => _messageBody = messageBody);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${_messageBody.id}')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(_messageBody.title),
            Divider(),
            Text(_messageBody.content),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
