import 'package:basic_engine/message/message_body.dart';
import 'package:basic_engine/message/message_source.dart';
import 'package:flutter/material.dart';

abstract class MessageListener<T extends StatefulWidget> extends State<T> {
  /// Do something with message.
  onReceiveMessage(MessageBody messageBody);

  @override
  void initState() {
    super.initState();
    MessageSource.getInstance().install(this);
  }

  @override
  void dispose() {
    MessageSource.getInstance().uninstall(this);
    super.dispose();
  }
}
