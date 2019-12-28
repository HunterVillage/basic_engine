import 'package:basic_engine/bundle/bundle.dart';
import 'package:basic_engine/constant/icon_constant.dart';
import 'package:flutter/material.dart';

class BundleShopping extends StatelessBundle {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: icon,
        title: Text('shopping', style: TextStyle(color: Colors.black, fontFamily: 'pinshang')),
      ),
    );
  }

  @override
  Widget get icon => Icon(MyIcons.shopping, color: Colors.pink);

  @override
  String get id => 'shopping';

  @override
  int get sort => 4;

  @override
  String get cnName => 'shopping';
}
