import 'package:basic_engine/app.dart';
import 'package:basic_engine/basic_app.dart';

import 'package:flutter/material.dart';

import 'bundle_deliver.dart';
import 'bundle_rest.dart';
import 'bundle_service.dart';
import 'bundle_shopping.dart';
import 'piano_album.dart';
import 'piano_card.dart';
import 'piano_collect.dart';
import 'piano_earth.dart';
import 'piano_expression.dart';
import 'piano_setting.dart';

const BASE_URL = 'http://172.16.5.106:8090/basic/';
const WS_URL = 'ws://172.16.5.106:8091';

const LOGO_PATH = "assets/images/logo.png";
const HOME_TITLE = "BASIC ENGINE";
const TITLE_LABEL = "Basic Engine";
const BACKGROUND_PATH = "assets/images/background.png";
const WELCOME_LABEL = "Albert Einstein: Logic will get you from A to B. Imagination will take you everywhere.";

Future<void> main() async {
  App app = App.getInstance();
  await app.init(baseUrl: BASE_URL, wsUrl: WS_URL);
  app.installBundles('Alpha', [BundleRest(), BundleDeliver(key: Key('a-deliver'))]);
  app.installBundles('Beta', [BundleService(), BundleShopping()]);
  app.installBundles('Gama', [BundleRest(), BundleDeliver(key: Key('c-Deliver')), BundleService(), BundleShopping()]);
  app.installPianos('Piano Group A', [PianoEarth()]);
  app.installPianos('Piano Group B', [PianoCollect(), PianoAlbum(), PianoCard(), PianoExpression()]);
  app.installPianos('Piano Group C', [PianoSetting()]);
  runApp(BasicApp(homeTitle: HOME_TITLE));
}
