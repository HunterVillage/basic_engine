import 'package:flutter/material.dart';

import 'bundle/bundle.dart';

class BundleDemo2 extends Bundle {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('demo2');
  }

  @override
  Widget getIcon() {
    // TODO: implement getIcon
    return Icon(Icons.pool);
  }

  @override
  String getId() {
    // TODO: implement getId
    return 'demo2';
  }

  @override
  int getSort() {
    // TODO: implement getSort
    return 2;
  }

  @override
  String getCnName() {
    // TODO: implement getCnName
    return '功能点2';
  }
}
