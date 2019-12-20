import 'package:basic_engine/bundle/bundle.dart';
import 'package:basic_engine/constant/icon_constant.dart';
import 'package:flutter/material.dart';

class BundleService extends StatelessBundle {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: icon,
        title: Text('service', style: TextStyle(color: Colors.black, fontFamily: 'pinshang')),
      ),
    );
  }

  @override
  Widget get icon => Icon(MyIcons.service, color: Colors.blueGrey);

  @override
  String get id => 'service';

  @override
  int get sort => 3;

  @override
  String get cnName => 'service';
}
