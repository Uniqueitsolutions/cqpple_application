import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetChecking extends StatefulWidget {
  const InternetChecking({Key? key}) : super(key: key);

  @override
  State<InternetChecking> createState() => _InternetCheckingState();
}

class _InternetCheckingState extends State<InternetChecking> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertBox = false;

  @override
  void initState() {

    getConnectivity();
    super.initState();
  }

  getConnectivity() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if(!isDeviceConnected){
      showDialogBox();
    }
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      print("Hello connectivity");
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && isAlertBox == false) {
        print("Hello");
        showDialogBox();
        setState(() {
          isAlertBox = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  showDialogBox() => showCupertinoDialog(
        context: context,
        builder: (context) {
          print("Hello");
          return CupertinoAlertDialog(
            title: Text(
              "No Connection",
            ),
            content: Text("Please check your internet connectivity"),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context,'Cancel');
                    setState(() {
                      isAlertBox = false;
                    });
                    isDeviceConnected =
                        await InternetConnectionChecker().hasConnection;
                    print(isDeviceConnected);
                    if (!isDeviceConnected) {
                      showDialogBox();
                      setState(() {
                        isAlertBox = true;
                      });
                    }
                  },
                  child: Text("Ok"))
            ],
          );
        },
      );
}
