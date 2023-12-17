import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/pages/homescreen_page.dart';
import 'package:bath_service_project/pages/login_page.dart';
import 'package:bath_service_project/pages/plumber_service_token_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/custom_textstyle.dart';
import '../custom/customappbar.dart';

class PlumberNotRegisteredPage extends StatefulWidget {
  const PlumberNotRegisteredPage({super.key});

  @override
  State<PlumberNotRegisteredPage> createState() =>
      _PlumberNotRegisteredPageState();
}

class _PlumberNotRegisteredPageState extends State<PlumberNotRegisteredPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomAppBar(
              title1: "",
              title2: "Plumber Service",
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 160),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: Colors.white),
                height: MediaQuery.of(context).size.height - 188,
                child: Container(
                  margin: const EdgeInsets.only(left: 33, right: 33, top: 40),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                                child: Icon(Icons.dangerous_outlined,
                                    size: 30,
                                    color: Color.fromRGBO(227, 59, 36, 1))),
                            Expanded(
                              flex: 5,
                              child: Text(
                                "Waiting For Approval",
                                style: GoogleFonts.poppins(
                                    color: const Color.fromRGBO(227, 59, 36, 1),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 10, left: 10),
                            child: CustomTextStyle(
                              title: "Your Request is not accepted.",
                            )),
                        CustomSubmitBotton(
                          title: "Exit",
                          margin_top: 50,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return LoginPage();
                              },
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Builder(builder: (context) {
              return TextButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  child: const CustomIcon());
            }),
          ],
        ),
        drawer: CustomDrawer(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
