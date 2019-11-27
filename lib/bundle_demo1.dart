import 'package:flutter/material.dart';

import 'bundle/bundle.dart';

class BundleDemo1 extends StatelessBundle {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Hero(tag: id, child: icon),
        title: Text('demo1'),
      ),
    );
  }

  @override
  Widget get icon => Image.asset('assets/images/bundle1.png');

  @override
  String get id => 'demo1';

  @override
  int get sort => 1;

  @override
  String get cnName => '功能点一';
}
