import 'package:basic_engine/bundle/piano.dart';
import 'package:basic_engine/constant/icon_constant.dart';
import 'package:flutter/material.dart';

import '../bundle/bundle.dart';

class PianoExpression extends StatelessPiano {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(tag: id, child: leading),
        title: Text('Expression'),
      ),
    );
  }

  @override
  Widget get leading => Icon(MyIcons.emoji, color: Colors.orange[400]);

  @override
  String get id => 'expression';

  @override
  int get sort => 5;

  @override
  String get cnName => '表情';
}
