import 'package:bath_service_project/custom/custom_textstyle.dart';
import 'package:bath_service_project/drawer_pages/help_page.dart';
import 'package:bath_service_project/drawer_pages/logout_page.dart';
import 'package:bath_service_project/pages/homescreen_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/login_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromRGBO(0, 65, 194, 1),
      width: MediaQuery.of(context).size.width>260? 250: 100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30)),
      ),
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ListTile(
              title: Image.asset("assets/icons/AppLogo.png",height: 100,width: 100),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.help,color: Colors.white,size: 25,),
              title: Text("Help",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return const HelpPage();
                },));
              },
            ),
          ),
          // Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10), child: const Divider(height: 2)),
          // SizedBox(
          //   height: 50,
          //   child: ListTile(
          //     leading: Image.asset("assets/icons/PrivacyPolicy.png",height: 30,width: 30,),
          //     title: CustomTextStyle(title: "Privacy Policy"),
          //     onTap: () {},
          //   ),
          // ),
          // Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10), child: const Divider(height: 2)),
          // SizedBox(
          //   height: 50,
          //   child: ListTile(
          //     leading: Image.asset("assets/icons/Share.png",height: 30,width: 30,),
          //     title: CustomTextStyle(title: "Share"),
          //     onTap: (){
          //
          //     },
          //   ),
          // ),
          Container(margin: const EdgeInsets.only(left: 20,right: 20), child: const Divider(height: 2,color: Colors.white,)),
          SizedBox(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.exit_to_app,color: Colors.white,size: 25,),
              title: Text("Logout",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove("ServiceID").then((value) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  },));
                });
              },
            ),
          ),
          Container(margin: const EdgeInsets.only(left: 20,right: 20), child: const Divider(height: 2,color: Colors.white,)),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text("\u00a9 2023 Unique IT Solution",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("All Rights Reversed - ",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // launch(
                        //     "http://www.darshan.ac.in/DIET/ASWDC-Mobile-Apps/Privacy-Policy-General");
                      },
                      child: Text("Privacy Policy",
                        style: GoogleFonts.poppins(
                            color: Colors.lightBlueAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text( "Made with ♥️ in India ",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text( "Version 1.0.0",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
