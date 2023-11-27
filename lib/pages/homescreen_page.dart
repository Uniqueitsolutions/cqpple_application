import 'package:bath_service_project/custom/internet_checking.dart';
import 'package:bath_service_project/pages/service_contactdetails_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom/custom_drawer.dart';
import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/customappbar.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                const InternetChecking(),
                CustomAppBar(
                  title1: "",
                  title2: "Home Screen",
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 188,
                        margin: const EdgeInsets.only(top: 160),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            color: Colors.white),
                        child: SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 33, right: 33, top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset("assets/images/Plumber.png"),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Add A Request",
                                    style: GoogleFonts.poppins(
                                        color:
                                            const Color.fromRGBO(29, 29, 29, 1),
                                        fontSize: 33,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Tap on the add button",
                                    style: GoogleFonts.poppins(
                                        color:
                                            const Color.fromRGBO(29, 29, 29, 1),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    "to create the service request",
                                    style: GoogleFonts.poppins(
                                        color:
                                            const Color.fromRGBO(29, 29, 29, 1),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                CustomSubmitBotton(
                                  title: "ADD",
                                  margin_top: 50,
                                  onTap: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return ServiceContactDetails(prefs
                                            .getString("Mobile_Number")
                                            .toString());
                                      },
                                    ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(builder: (context) {
                  return TextButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      child: const CustomIcon());
                }),
              ],
            ),
            drawer: const CustomDrawer(),
            resizeToAvoidBottomInset: false,
          ),
        ));
  }
}
