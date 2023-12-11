import 'package:bath_service_project/custom/internet_checking.dart';
import 'package:bath_service_project/pages/dealer_login_page.dart';

import 'package:bath_service_project/pages/homescreen_page.dart';
import 'package:bath_service_project/pages/login_page.dart';
import 'package:bath_service_project/pages/plumber_notregistered_page.dart';
import 'package:bath_service_project/pages/plumber_registration_page.dart';
import 'package:bath_service_project/pages/plumber_service_token_page.dart';
import 'package:bath_service_project/pages/plumber_servicedetails_page.dart';
import 'package:bath_service_project/pages/service_contactdetails_page.dart';
import 'package:bath_service_project/pages/service_request_page.dart';
import 'package:bath_service_project/pages/service_status_page.dart';
import 'package:bath_service_project/pages/login_verification_page.dart';

import 'package:bath_service_project/pages/splashscreen_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final PushNotificationService _notificationService = PushNotificationService();
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // _notificationService.initialize();

    return MaterialApp(
        title: 'Cqpple',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen());
  }
}
