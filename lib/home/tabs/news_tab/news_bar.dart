/// @author wujianchuan
/// @date 2019/12/18 15:12
import 'package:flutter/material.dart';

class NewsBar extends StatelessWidget {
  final double height;

  const NewsBar({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(color: Colors.grey[300]),
          height: height,
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text("消  息", style: TextStyle(fontFamily: 'pinshang', fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ],
    );
  }
}
