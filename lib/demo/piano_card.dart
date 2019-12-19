import 'package:basic_engine/bundle/piano.dart';
import 'package:basic_engine/constant/icon_constant.dart';
import 'package:flutter/material.dart';

import '../bundle/bundle.dart';

class PianoCard extends StatelessPiano {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(tag: id, child: leading),
        title: Text('card'),
      ),
    );
  }

  @override
  Widget get leading => Icon(MyIcons.setting, color: Colors.teal[200]);

  @override
  String get id => 'card';

  @override
  int get sort => 4;

  @override
  String get cnName => '卡    包';
}
