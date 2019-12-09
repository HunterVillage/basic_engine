import 'package:basic_engine/app.dart';
import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/bundle/bundle.dart';
import 'package:flutter/material.dart';

import 'bundle_demo1.dart';
import 'bundle_demo2.dart';

const BASE_URL = 'http://192.168.43.245:8090/ares/';
const WS_URL = 'ws://192.168.43.245:8091';

const LOGO_PATH = "assets/images/logo.png";
const HOME_TITLE = "BASIC ENGINE";
const TITLE_LABEL = "Basic Engine";
const BACKGROUND_PATH = "assets/images/background.png";
const WELCOME_LABEL = "Albert Einstein: Logic will get you from A to B. Imagination will take you everywhere.";

final List<Bundle> bundles = [BundleDemo1(), BundleDemo2()];
final BasicApp basicApp = BasicApp(
  homeTitle: HOME_TITLE,
);

main() async {
  await App.getInstance().init(bundles: bundles, baseUrl: BASE_URL, wsUrl: WS_URL);
  runApp(basicApp);
}
