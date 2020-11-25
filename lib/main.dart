import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkup/app/Pages/login.dart';
import 'package:linkup/app/config/push_notification_configure.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = await PushNotificationConfigure().configure();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  Timer(Duration(seconds: 1), () {
    print(token);
    sharedPreferences.setString("tokenNotification", token);
  });
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
    theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff6700F1),
        brightness: Brightness.light,
        accentColor: Colors.white,
        primaryColor: Color(0xff6700f1)),
  ));
}
