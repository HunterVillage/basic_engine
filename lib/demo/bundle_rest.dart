import 'package:basic_engine/constant/icon_constant.dart';
import 'package:basic_engine/demo/piano_earth.dart';
import 'package:flutter/material.dart';

import '../bundle/bundle.dart';

class BundleRest extends StatelessBundle {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: icon,
        title: Text('rest', style: TextStyle(color: Colors.black, fontFamily: 'pinshang')),
      ),
      body: Earth(),
    );
  }

  @override
  Widget get icon => Icon(MyIcons.rest, color: Colors.teal);

  @override
  String get id => 'rest';

  @override
  int get sort => 1;

  @override
  String get cnName => 'rest';
}
