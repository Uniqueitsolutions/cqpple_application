import 'dart:io';

import 'package:bath_service_project/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  bool? isLogoutAvailable;
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: <Widget>[
          Text(
            "Do you want to exit?",
            style: GoogleFonts.openSans(fontWeight: FontWeight.w900),
          ),
        ],
      ),
      actions: <Widget>[
        CupertinoDialogAction(
            child: Text(
              "Yes",
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold, color: Colors.red),
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              isLogoutAvailable = prefs.getBool("isLogoutAvailable") ?? true;
              if (isLogoutAvailable ?? true) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("ServiceID");
                prefs.remove("Role");
                prefs.remove("apikey");
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ));
              } else {
                Navigator.of(context, rootNavigator: true).pop();
              }
            }),
        CupertinoDialogAction(
          child: Text(
            "No",
            style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
  }
}
