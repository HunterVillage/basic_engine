import 'package:basic_engine/app.dart';
import 'package:basic_engine/basic_app.dart';
import 'package:basic_engine/demo/bundle_demo1.dart';
import 'package:basic_engine/demo/bundle_demo3.dart';
import 'package:basic_engine/demo/bundle_demo4.dart';
import 'package:basic_engine/demo/piano_album.dart';
import 'package:basic_engine/demo/piano_card.dart';
import 'package:basic_engine/demo/piano_expression.dart';
import 'package:basic_engine/demo/piano_setting.dart';
import 'package:basic_engine/demo/piano_pay.dart';
import 'package:basic_engine/demo/piano_collect.dart';
import 'package:flutter/material.dart';

import 'bundle_demo2.dart';

const BASE_URL = 'http://192.168.43.245:8090/ares/';
const WS_URL = 'ws://192.168.43.245:8091';

const LOGO_PATH = "assets/images/logo.png";
const HOME_TITLE = "BASIC ENGINE";
const TITLE_LABEL = "Basic Engine";
const BACKGROUND_PATH = "assets/images/background.png";
const WELCOME_LABEL = "Albert Einstein: Logic will get you from A to B. Imagination will take you everywhere.";

Future<void> main() async {
  App app = App.getInstance();
  await app.init(baseUrl: BASE_URL, wsUrl: WS_URL);
  app.installBundles('Bundle Group A', [BundleDemo1(), BundleDemo2()]);
  app.installBundles('Bundle Group B', [BundleDemo3(), BundleDemo4()]);
  app.installBundles('Bundle Group C', [BundleDemo1(), BundleDemo2(), BundleDemo3()]);
  app.installPianos('Piano Group A', [PianoPay()]);
  app.installPianos('Piano Group B', [PianoCollect(), PianoAlbum(), PianoCard(), PianoExpression()]);
  app.installPianos('Piano Group C', [PianoSetting()]);
  runApp(BasicApp(homeTitle: HOME_TITLE));
}
