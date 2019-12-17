import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/message/message_body.dart';
import 'package:basic_engine/message/notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  final String uuid;

  NewsDetail(this.uuid);

  @override
  State<StatefulWidget> createState() => NewsDetailState();
}

class NewsDetailState extends State<NewsDetail> {
  MessageBody _messageBody;
  String _messageUuid;

  @override
  void initState() {
    super.initState();
    _messageUuid = widget.uuid;
    MessageBody messageBody = app.messageBox.popUnreadMessage(_messageUuid);
    this.setState(() => _messageBody = messageBody);
    notifierSubject.stream.listen((uuid) {
      if (_messageUuid == null || _messageUuid != uuid) {
        if (mounted) {
          _messageUuid = uuid;
          MessageBody messageBody = app.messageBox.popUnreadMessage(_messageUuid);
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
