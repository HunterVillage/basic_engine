import 'package:basic_engine/message/message_source.dart';
import 'package:flutter/material.dart';

abstract class MessageListener<T extends StatefulWidget> extends State<T> {
  /// Do something with message.
  onReceiveMessage(String message);

  @override
  void initState() {
    super.initState();
    MessageSource.getInstance().install(this);
  }
}
