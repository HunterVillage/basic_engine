import 'package:basic_engine/bundle/bundle.dart';
import 'package:basic_engine/constant/icon_constant.dart';
import 'package:flutter/material.dart';

class BundleDeliver extends StatelessBundle {
  BundleDeliver({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: Hero(tag: key, child: icon),
        title: Text('deliver', style: TextStyle(color: Colors.black, fontFamily: 'pinshang')),
      ),
    );
  }

  @override
  Widget get icon => Icon(MyIcons.deliver, color: Colors.brown);

  @override
  String get id => 'deliver';

  @override
  int get sort => 2;

  @override
  String get cnName => 'deliver';
}
