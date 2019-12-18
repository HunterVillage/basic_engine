import 'package:basic_engine/bundle/bundle_boss.dart';
import 'package:basic_engine/common/global.dart';
import 'package:basic_engine/home/tabs/menu_tab/menu_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuCenter extends StatefulWidget {
  final String title;

  MenuCenter(this.title);

  @override
  State<StatefulWidget> createState() => MenuCenterState();
}

class MenuCenterState extends State<MenuCenter> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  bool _shortcutOpen;

  @override
  void initState() {
    super.initState();
    _shortcutOpen = false;
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween(begin: -132.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    shortcutSubject.stream.listen((shortcutBundleIds) {
      if (mounted) this.setState(() {});
    });
  }

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
                    children: BundleBoss.groupingMenus(context),
                  ),
                ),
              ),
            ),
          ),
          _buildShortcutMenus(),
          _buildShortcutMenusButton(),
        ],
      ),
    );
  }

  Positioned _buildShortcutMenus() {
    return Positioned(
      right: _animation.value,
      bottom: 0,
      top: MediaQuery.of(context).padding.top,
      child: Container(
        padding: EdgeInsets.all(10),
        width: 130,
        decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(5)), color: Colors.black38),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: BundleBoss.shortcutMenus(context),
          ),
        ),
      ),
    );
  }

  Positioned _buildShortcutMenusButton() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        child: Opacity(
          opacity: 0.7,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10)), color: Colors.black38),
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _controller,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          if (_shortcutOpen) {
            _controller.reverse();
            this.setState(() => _shortcutOpen = false);
          } else {
            _controller.forward();
            this.setState(() => _shortcutOpen = true);
          }
        },
      ),
    );
  }
}
