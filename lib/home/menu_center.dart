import 'package:basic_engine/bundle/bundle_boss.dart';
import 'package:flutter/cupertino.dart';

class MenuCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MenuCenterState();
}

class MenuCenterState extends State<MenuCenter> {
  List<Widget> _bundles;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Wrap(
          children: this._bundles,
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    this._bundles = BundleBoss.mapToWidget(super.context);
  }
}
