import 'package:flutter/material.dart';

import 'bundle/bundle_boss.dart';
import 'bundle_demo1.dart';
import 'bundle_demo2.dart';

void main() {
  BundleBoss.register(BundleDemo1());
  BundleBoss.register(BundleDemo2());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _bundles;

  @override
  void initState() {
    super.initState();
    this._bundles = BundleBoss.mapToWidget(super.context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Wrap(
            children: this._bundles,
          )
        ],
      ),
    );
  }
}
