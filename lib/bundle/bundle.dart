import 'package:flutter/material.dart';

abstract class Bundle extends Widget {
  int get sort;

  Widget get icon;

  String get id;

  String get cnName;
}

abstract class StatelessBundle extends StatelessWidget implements Bundle {
}

abstract class StatefulBundle extends StatefulWidget implements Bundle {
}
