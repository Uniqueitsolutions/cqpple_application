import 'dart:convert';

import 'package:bath_service_project/Utils/preference.dart';
import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/custom/custom_loader.dart';
import 'package:bath_service_project/custom/custom_textstyle.dart';
import 'package:bath_service_project/custom/internet_checking.dart';
import 'package:bath_service_project/pages/login_verification_page.dart';
import 'package:bath_service_project/pages/plumber_registration_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/customappbar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  String validation_message = "";
  bool valid_mobile_number = true;
  String apiKey = "1234567890";
  bool isLoading = false;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobile_number = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                title2: "Login",
              ),
              Container(
                margin: const EdgeInsets.only(top: 160),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height - 188,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(left: 33, right: 33, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Welcome",
                          style: GoogleFonts.poppins(
                              fontSize: 32,
                              color: const Color.fromRGBO(29, 29, 29, 1),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Hello There, Please Login",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: const Color.fromRGBO(29, 29, 29, 1),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 32),
                          child: CustomTextStyle(title: "Mobile Number"),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: mobile_number,
                              validator: (value) {
                                RegExp regex = RegExp(
                                    "^(?:(?:\\+|0{0,2})91(\\s*[\\-]\\s*)?|[0]?)?[789]\\d{9}\$");
                                bool match = regex.hasMatch(value.toString());
                                if (value == null || value == "") {
                                  return "* Please Enter Mobile Number";
                                }
                                if (!match) {
                                  return "* Please Enter Valid Mobile Number";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(top: 5),
                                prefixIcon: const Icon(Icons.call),
                                hintText: "Please Enter Your Mobile Number",
                                hintStyle: GoogleFonts.poppins(
                                    color:
                                        const Color.fromRGBO(181, 181, 181, 1),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                fillColor:
                                    const Color.fromRGBO(246, 246, 246, 1),
                                filled: true,
                              ),
                              style: GoogleFonts.poppins(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        CustomSubmitBotton(
                          title: "Login",
                          margin_top: 45,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              PreferencesManager.saveAPIKey(
                                  mobile_number.text.toString());
                              await requestForOTP().then(
                                (response) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      widget.isLoading = false;
                                      return LoginVerificationPage(response,
                                          mobile_number.text.toString());
                                    },
                                  ));
                                },
                              );
                            }

                            // if(mobile_number)
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Text(
                            "-- OR --",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: const Color.fromRGBO(181, 181, 181, 1),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        CustomSubmitBotton(
                          title: "Plumber Registration",
                          margin_top: 30,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return PlumberRegistrationPage();
                              },
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              widget.isLoading
                  ? CustomLoader(
                      opacity: 0.60,
                    )
                  : Container(),
              Builder(builder: (context) {
                return TextButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    child: const CustomIcon());
              }),
            ],
          ),
          drawer: CustomDrawer(hasLogout: false),
          resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }

  Future<dynamic> requestForOTP() async {
    setState(() {
      widget.isLoading = true;
    });
    var apiURL = "https://cqpplefitting.com/ad_cqpple/Api/login";
    Map<String, String> map = {};
    map["apikey"] = widget.apiKey;
    map["ContactNumber"] = mobile_number.text.toString();
    var response = await http.post(Uri.parse(apiURL), body: jsonEncode(map));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }
}
