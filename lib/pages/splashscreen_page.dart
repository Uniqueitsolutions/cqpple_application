import 'dart:io';
import 'package:bath_service_project/Utils/preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bath_service_project/Utils/web_service.dart';
import 'package:bath_service_project/pages/homescreen_page.dart';
import 'package:bath_service_project/pages/login_page.dart';
import 'package:bath_service_project/pages/plumber_notregistered_page.dart';
import 'package:bath_service_project/pages/plumber_service_token_page.dart';
import 'package:bath_service_project/pages/service_status_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'dealer_login_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  String? serviceID, mobileNumberResponse;
  bool isPlumberApproved = false;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AnimatedSplashScreen(
              splash: 'assets/icons/AppLogo.png',
              splashIconSize: 300,
              nextScreen: getNextScreen(),
              splashTransition: SplashTransition.sizeTransition,
              pageTransitionType: PageTransitionType.bottomToTop,
            );
          } else {
            return Center(child: Container());
          }
        },
        future: flag ? setServiceID() : null,
      ),
    );
  }

  Widget getNextScreen() {
    var role = PreferencesManager.getRole();
    if (role == UserRole.plumber) {
      if (widget.isPlumberApproved) {
        return PlumberServiceTokenPage();
      } else {
        return const PlumberNotRegisteredPage();
      }
    } else if (role == UserRole.dealer) {
      return const DealerLoginPage();
    } else if (role == UserRole.endUser) {
      if (widget.serviceID != null &&
          widget.serviceID != "" &&
          widget.serviceID != "null") {
        return ServiceStatusPage(
          ServiceID: widget.serviceID,
        );
      } else {
        return const HomeScreenPage();
      }
    } else {
      return LoginPage();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<int> setServiceID() async {
    final serviceID = PreferencesManager.getServiceId();
    final role = PreferencesManager.getRole();
    if (role == UserRole.plumber) {
      await plumberApproveStatus();
    }
    setState(() {
      widget.serviceID = serviceID;
      if (kDebugMode) {
        print("ServiceID splash :$serviceID");
      }
      flag = false;
    });
    return 0;
  }

  Future<void> plumberApproveStatus() async {
    final apiKey = PreferencesManager.getAPIKey();
    final applicationUserID = PreferencesManager.getApplicationUserID();
    var apiURL = "https://cqpplefitting.com/ad_cqpple/Api/IsServiceManApprove";
    Map map = {};
    map["apikey"] = apiKey;
    map["ApplicationUserID"] = applicationUserID;
    if (kDebugMode) {
      print(map);
    }
    var response = await http.post(Uri.parse(apiURL), body: jsonEncode(map));
    if (kDebugMode) {
      print(response.statusCode);
    }
    final json = jsonDecode(response.body);
    widget.isPlumberApproved = json["IsPlumberApproved"].toString() == "true";
  }
}
