import 'package:flutter/material.dart';

import 'bundle/bundle.dart';

class BundleDemo2 extends Bundle {
  @override
  Widget build(BuildContext context) {
    return Text('demo2');
  }

  @override
  Widget get icon => Image.asset('assets/images/bundle2.png');

  @override
  String get id => 'demo2';

  @override
  int get sort => 2;

  @override
  String get cnName => '功能点二';
}
