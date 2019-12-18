import 'package:basic_engine/bundle/bundle_boss.dart';
import 'package:basic_engine/home/tabs/menu_tab/menu_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuCenter extends StatefulWidget {
  final String title;

  MenuCenter(this.title);

  @override
  State<StatefulWidget> createState() => MenuCenterState();
}

class MenuCenterState extends State<MenuCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MenuBar(radius: 115),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 5),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: BundleBoss.mapToWidget(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
