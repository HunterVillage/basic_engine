import 'package:flutter/material.dart';

import 'bundle/bundle.dart';

class BundleDemo3 extends StatelessBundle {
  @override
  Widget build(BuildContext context) {
    return Text('demo3');
  }

  @override
  Widget get icon => Image.asset('assets/images/bundle2.png');

  @override
  String get id => 'demo3';

  @override
  int get sort => 3;

  @override
  String get cnName => '功能点三';
}
