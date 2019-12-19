import 'package:basic_engine/bundle/piano.dart';
import 'package:basic_engine/constant/icon_constant.dart';
import 'package:flutter/material.dart';

import '../bundle/bundle.dart';

class PianoAlbum extends StatelessPiano {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(tag: id, child: leading),
        title: Text('Album'),
      ),
    );
  }

  @override
  Widget get leading => Icon(MyIcons.picture, color: Colors.blueAccent[200]);

  @override
  String get id => 'album';

  @override
  int get sort => 3;

  @override
  String get cnName => '相    册';
}