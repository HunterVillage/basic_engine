import 'package:flutter/material.dart';

abstract class Bundle extends Widget {
  int get sort;

  Widget get icon;

  String get id;

  String get cnName;
}

abstract class StatelessBundle extends StatelessWidget implements Bundle {
  const StatelessBundle({ Key key }) : super(key: key);
}

abstract class StatefulBundle extends StatefulWidget implements Bundle {
  const StatefulBundle({ Key key }) : super(key: key);
}
