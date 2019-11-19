import 'package:flutter/material.dart';

abstract class Bundle extends StatelessWidget {
  int getSort();

  Widget getIcon();

  String getId();

  String getCnName();
}
