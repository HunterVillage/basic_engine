import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class Notifier {
  static Notifier _instance = Notifier._();
  num _notificationId = 0;

  Notifier._();

  static Notifier getInstance() {
    return _instance;
  }

  Future init() async {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(initializationSettingsAndroid, null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    _notificationId--;
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  Future<void> showBigTextNotification(String title, String content) async {
    var bigTextStyleInformation =
        BigTextStyleInformation(content, htmlFormatBigText: true, contentTitle: title, htmlFormatContentTitle: true, summaryText: '新消息', htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'bigTextChannel',
      '大文本通道',
      '大文本任务提示',
      style: AndroidNotificationStyle.BigText,
      styleInformation: bigTextStyleInformation,
    );
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(++_notificationId, title, content, platformChannelSpecifics, payload: 'hello world');
  }
}
