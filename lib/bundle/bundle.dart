import 'package:flutter/material.dart';

abstract class Bundle extends StatelessWidget {
  int get sort;

  Widget get icon;

  String get id;

  String get cnName;
}
