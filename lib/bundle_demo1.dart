import 'package:flutter/material.dart';

import 'bundle/bundle.dart';

class BundleDemo1 extends Bundle {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('demo1');
  }

  @override
  Widget getIcon() {
    // TODO: implement getIcon
    return Icon(Icons.hourglass_empty);
  }

  @override
  String getId() {
    // TODO: implement getId
    return 'demo1';
  }

  @override
  int getSort() {
    // TODO: implement getSort
    return 1;
  }

  @override
  String getCnName() {
    // TODO: implement getCnName
    return '功能点一';
  }
}
