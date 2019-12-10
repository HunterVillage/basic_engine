import 'package:basic_engine/bundle/bundle_boss.dart';
import 'package:flutter/cupertino.dart';

class MenuCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MenuCenterState();
}

class MenuCenterState extends State<MenuCenter> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: BundleBoss.mapToWidget(context),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
