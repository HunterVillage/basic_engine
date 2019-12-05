import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/bundle/bundle.dart';
import 'package:flutter/material.dart';

import 'bundle_demo1.dart';
import 'bundle_demo2.dart';

const BASE_URL = 'http://172.16.4.33:8090/ares/';
const WS_URL = 'ws://172.16.4.33:8091';

const LOGO_PATH = "assets/images/logo.png";
const HOME_TITLE = "BASIC ENGINE";
const TITLE_LABEL = "Basic Engine";
const BACKGROUND_PATH = "assets/images/background.png";
const WELCOME_LABEL = "Albert Einstein: Logic will get you from A to B. Imagination will take you everywhere.";

final List<Bundle> bundles = [BundleDemo1(), BundleDemo2()];

main() async {
  basicApp = BasicApp(
    logoPath: LOGO_PATH,
    homeTitle: HOME_TITLE,
    loginBackgroundPath: BACKGROUND_PATH,
    loginTitle: TITLE_LABEL,
    loginSubTitle: WELCOME_LABEL,
  );
  await basicApp.preparation(bundles: bundles, baseUrl: BASE_URL, wsUrl: WS_URL);
  runApp(basicApp);
}
