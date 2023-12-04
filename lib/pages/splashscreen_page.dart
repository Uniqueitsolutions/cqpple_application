import 'dart:io';

import 'package:bath_service_project/Utils/web_service.dart';
import 'package:bath_service_project/pages/homescreen_page.dart';
import 'package:bath_service_project/pages/login_page.dart';
import 'package:bath_service_project/pages/plumber_notregistered_page.dart';
import 'package:bath_service_project/pages/plumber_service_token_page.dart';
import 'package:bath_service_project/pages/service_status_page.dart';
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

  String? serviceID, role, mobileNumberResponse;
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
    if (widget.serviceID == null || widget.serviceID == "null") {
      if (widget.role == "Plumber") {
        if (widget.isPlumberApproved) {
          return PlumberServiceTokenPage();
        } else {
          return const PlumberNotRegisteredPage();
        }
      } else if (widget.role == "Dealer") {
        return const DealerLoginPage();
      } else if (widget.role == "End-User") {
        return const HomeScreenPage();
      } else {
        return LoginPage();
      }
    } else {
      return ServiceStatusPage(
        ServiceID: widget.serviceID,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      WebServices.getDeleteAccountFlag().then((response) {
        SharedPreferences.getInstance().then((pref) {
          pref.setBool("allowDeleteAccount", response.status);
        });
      });
    } else {
      SharedPreferences.getInstance().then((pref) {
        pref.setBool("allowDeleteAccount", false);
      });
    }
  }

  Future<int> setServiceID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final serviceID = prefs.getString("ServiceID");
    final role = prefs.getString("Role");
    if (role == "Plumber") {
      await plumberApproveStatus();
    }
    setState(() {
      widget.serviceID = serviceID;
      widget.role = role;
      print("ServiceID splash :${serviceID ?? ""}");
      flag = false;
    });
    return 0;
  }

  Future<void> plumberApproveStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final apiKey = prefs.getString("apikey");
    final applicationUserID = prefs.getString("ApplicationUserID");
    var apiURL = "https://cqpplefitting.com/ad_cqpple/Api/IsServiceManApprove";
    Map map = {};
    map["apikey"] = apiKey ?? "";
    map["ApplicationUserID"] = applicationUserID ?? "";
    print(map);
    var response = await http.post(Uri.parse(apiURL), body: jsonEncode(map));
    print(response.statusCode);
    final json = jsonDecode(response.body);
    widget.isPlumberApproved = json["IsPlumberApproved"].toString() == "true";
  }
}
