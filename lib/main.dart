import 'package:basic_engine/app.dart';
import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/bundle_demo3.dart';
import 'package:basic_engine/bundle_demo4.dart';
import 'package:flutter/material.dart';

import 'bundle_demo1.dart';
import 'bundle_demo2.dart';

const BASE_URL = 'http://172.16.4.197:8090/ares/';
const WS_URL = 'ws://172.16.4.197:8091';

const LOGO_PATH = "assets/images/logo.png";
const HOME_TITLE = "BASIC ENGINE";
const TITLE_LABEL = "Basic Engine";
const BACKGROUND_PATH = "assets/images/background.png";
const WELCOME_LABEL = "Albert Einstein: Logic will get you from A to B. Imagination will take you everywhere.";

Future<void> main() async {
  App app = App.getInstance();
  app.installBundles('Group A', [BundleDemo1(), BundleDemo2()]);
  app.installBundles('Group B', [BundleDemo3(), BundleDemo4()]);
  app.installBundles('Group C', [BundleDemo1(), BundleDemo2(), BundleDemo3()]);
  await app.init(baseUrl: BASE_URL, wsUrl: WS_URL);
  runApp(BasicApp(homeTitle: HOME_TITLE));
}
