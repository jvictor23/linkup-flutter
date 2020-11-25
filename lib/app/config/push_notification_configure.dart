import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:linkup/app/config/push_notification/push_notification_factory.dart';

class PushNotificationConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationDetails platformChannelSpecifics;

  Future<String> configure() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'push_notification_PirineusExpress',
            'push_notification_PirineusExpress_Name',
            'push_notification_PirineusExpress_description',
            importance: Importance.max,
            priority: Priority.high,
            groupAlertBehavior: GroupAlertBehavior.all);

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _processMessage(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _processMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    // print("Token: ${await _fcm.getToken()}");

    return _fcm.getToken();
  }

  void _processMessage(message) {
    _flutterLocalNotificationShow(message);
  }

  void _flutterLocalNotificationShow(message) async {
    String payload;
    if (Platform.isIOS) {
      payload = message["payload"];
    } else {
      payload = message["data"]["payload"];
    }

    await flutterLocalNotificationsPlugin.show(
        0,
        message["notification"]["title"],
        message["notification"]["body"],
        platformChannelSpecifics,
        payload: payload);
  }

  static Future myBackgroundMessageHandler(Map<String, dynamic> message) {}

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {}

  Future onSelectNotification(String payload) {
    if (payload != null) {
      PushNotificationFactory.create(jsonDecode(payload))..execute();
    }
  }
}
