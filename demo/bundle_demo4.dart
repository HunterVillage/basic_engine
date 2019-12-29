import 'package:basic_engine/bundle/bundle.dart';
import 'package:flutter/material.dart';

class BundleDemo4 extends StatelessBundle {
  @override
  Widget build(BuildContext context) {
    return Text('demo4');
  }

  @override
  Widget get icon => Image.asset('assets/images/bundle2.png');

  @override
  String get id => 'demo4';

  @override
  int get sort => 4;

  @override
  String get cnName => '功能点四';
}
