import 'package:bath_service_project/pages/login_page.dart';
import 'package:bath_service_project/pages/service_status_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  String? ServiceID;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  bool flag=true;
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return AnimatedSplashScreen(
              splash: 'assets/icons/AppLogo.png',splashIconSize: 300,
              nextScreen: widget.ServiceID.toString()=="null" ? LoginPage():ServiceStatusPage(ServiceID: widget.ServiceID,),
              splashTransition: SplashTransition.sizeTransition,
              pageTransitionType: PageTransitionType.bottomToTop,
            );
          }
          else{
            return Center(child: Container());
          }
        },
        future: flag? setServiceID():null,
      ),
    );
  }

  Future<int> setServiceID() async {
    print("Hello");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ServiceID = await prefs.getString("ServiceID")??null;
    print("Hello World");
    setState(() {
      widget.ServiceID = ServiceID;
      print("ServiceID splash :"+widget.ServiceID.toString());
      flag=false;
    });
    return 0;
  }
}
