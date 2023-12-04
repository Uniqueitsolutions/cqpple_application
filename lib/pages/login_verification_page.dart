import 'dart:async';
import 'dart:convert';

import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/custom/custom_loader.dart';
import 'package:bath_service_project/custom/custom_textstyle.dart';
import 'package:bath_service_project/pages/dealer_login_page.dart';
import 'package:bath_service_project/pages/homescreen_page.dart';
import 'package:bath_service_project/pages/plumber_notregistered_page.dart';
import 'package:bath_service_project/pages/plumber_service_token_page.dart';
import 'package:bath_service_project/pages/service_contactdetails_page.dart';
import 'package:bath_service_project/pages/service_status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/customappbar.dart';
import '../custom/otp_button_row.dart';

class LoginVerificationPage extends StatefulWidget {
  String apiKey = "1234567890";
  String mobile_number = "";
  dynamic mobileNumberResponse = "";
  bool isLoading = false;
  String apiKey2 = "";

  String? ServiceID;
  var isEnteredOTPValid = false;

  LoginVerificationPage(this.mobileNumberResponse, this.mobile_number,
      {super.key});

  @override
  State<LoginVerificationPage> createState() => _LoginVerificationPageState();
}

class _LoginVerificationPageState extends State<LoginVerificationPage> {
  bool invalidOTP = false;
  var otpFieldController1 = TextEditingController();
  var otpFieldController2 = TextEditingController();
  var otpFieldController3 = TextEditingController();
  var otpFieldController4 = TextEditingController();

  final focusOn2ndField = FocusNode();
  final focusOn3rdField = FocusNode();
  final focusOn4thField = FocusNode();
  final _formkey = GlobalKey<FormState>();

  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  // var ApplicationUserID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          CustomAppBar(title2: "Login"),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 27),
                      child: Text(
                        "Verification",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 28,
                            fontStyle: FontStyle.normal,
                            color: const Color.fromRGBO(29, 29, 29, 1)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35, left: 28),
                    child: CustomTextStyle(
                      title: "Enter Your OTP Code Number",
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 18, right: 28),
                    child: Form(
                      key: _formkey,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                controller: otpFieldController1,
                                validator: (value) {
                                  if (value == null || value == "") {
                                    widget.isEnteredOTPValid = true;
                                    return null;
                                  }
                                  widget.isEnteredOTPValid = false;
                                  return null;
                                },
                                style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: const Color.fromRGBO(29, 29, 29, 1)),
                                onChanged: (value) {
                                  setState(() {
                                    if (value.length == 1) {
                                      FocusScope.of(context)
                                          .requestFocus(focusOn2ndField);
                                    }
                                  });
                                },
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                controller: otpFieldController2,
                                validator: (value) {
                                  if (value == null || value == "") {
                                    widget.isEnteredOTPValid = true;
                                    return null;
                                  }
                                  widget.isEnteredOTPValid = false;
                                  return null;
                                },
                                style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: const Color.fromRGBO(29, 29, 29, 1)),
                                focusNode: focusOn2ndField,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  setState(() {
                                    if (value.length == 1) {
                                      FocusScope.of(context)
                                          .requestFocus(focusOn3rdField);
                                    }
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                controller: otpFieldController3,
                                validator: (value) {
                                  if (value == null || value == "") {
                                    setState(() {
                                      widget.isEnteredOTPValid = true;
                                    });
                                    return null;
                                  }
                                  widget.isEnteredOTPValid = false;
                                  return null;
                                },
                                style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: const Color.fromRGBO(29, 29, 29, 1)),
                                focusNode: focusOn3rdField,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  setState(() {
                                    if (value.length == 1) {
                                      FocusScope.of(context)
                                          .requestFocus(focusOn4thField);
                                    }
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              // color: Colors.transparent,
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                controller: otpFieldController4,
                                validator: (value) {
                                  if (value == null || value == "") {
                                    widget.isEnteredOTPValid = true;
                                    return null;
                                  }
                                  widget.isEnteredOTPValid = false;
                                  return null;
                                },
                                style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: const Color.fromRGBO(29, 29, 29, 1)),
                                focusNode: focusOn4thField,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  invalidOTP
                      ? Container(
                          margin: const EdgeInsets.only(top: 10, left: 33),
                          child: Text(
                            "Incorrect OTP",
                            style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        )
                      : Container(),
                  widget.isEnteredOTPValid
                      ? Container(
                          margin: const EdgeInsets.only(top: 10, left: 33),
                          child: Text(
                            "Please Enter Valid OTP",
                            style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        )
                      : Container(),
                  Container(
                    margin: const EdgeInsets.only(left: 33, right: 33, top: 30),
                    child: CustomSubmitBotton(
                      margin_top: 40,
                      title: "Verify",
                      onTap: () async {
                        if (_formkey.currentState!.validate() &&
                            !widget.isEnteredOTPValid) {
                          await requestForOTPVerification().then(
                            (response) async {
                              widget.isLoading = false;
                              if (response["status"]) {
                                invalidOTP = false;
                                String role =
                                    widget.mobileNumberResponse["data"]["Role"];
                                if (role == "Dealer") {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const DealerLoginPage();
                                      },
                                    ),
                                  );
                                } else if (role == "Plumber") {
                                  await plumberApproveStatus().then((response) {
                                    if (response["IsPlumberApproved"]
                                            .toString() ==
                                        "true") {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return PlumberServiceTokenPage();
                                          },
                                        ),
                                      );
                                    } else {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const PlumberNotRegisteredPage();
                                          },
                                        ),
                                      );
                                    }
                                  });
                                } else {
                                  if (widget.ServiceID == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.green,
                                            content:
                                                Text("Login Successfully")));
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const HomeScreenPage();
                                        },
                                      ),
                                    );
                                  } else {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return ServiceStatusPage(
                                          ServiceID: widget.ServiceID,
                                        );
                                      },
                                    ));
                                  }
                                }
                              } else {
                                setState(() {
                                  widget.isLoading = false;
                                  invalidOTP = true;
                                  otpFieldController1.text = "";
                                  otpFieldController2.text = "";
                                  otpFieldController3.text = "";
                                  otpFieldController4.text = "";
                                });
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Text(
                        "Didn't You Receive Any Code ?",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: const Color.fromRGBO(181, 181, 181, 1)),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: enableResend ? _resendCode : null,
                        child: Text(
                          "Resend New Code",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              color: const Color.fromRGBO(0, 65, 194, 1)),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      secondsRemaining == 0
                          ? ""
                          : "after $secondsRemaining seconds",
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ],
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
      drawer: CustomDrawer(),
    ));
  }

  Future<dynamic> requestForOTPVerification() async {
    widget.isLoading = true;
    var apiURL = "https://cqpplefitting.com/ad_cqpple/Api/login";
    String userOTP = otpFieldController1.text.toString() +
        otpFieldController2.text.toString() +
        otpFieldController3.text.toString() +
        otpFieldController4.text.toString();
    Map<String, String> map = {};
    map["apikey"] = widget.apiKey;
    map["ContactNumber"] = widget.mobile_number;
    map["UserOtp"] = userOTP;
    map["ApplicationUserID"] =
        widget.mobileNumberResponse["data"]["ApplicationUserID"];
    map["FcmToken"] = "2546";
    print(userOTP);
    var response = await http.post(Uri.parse(apiURL), body: jsonEncode(map));
    print(response.statusCode);
    print("=======requestForOTPVerification=======");
    print(response.body);
    print("==========================================");

    var json = jsonDecode(response.body);
    if (jsonDecode(response.body)["status"]) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("apikey", json["data"]["apikey"]);
      await prefs.setString("ServiceID", json["data"]["ServiceID"] ?? "null");
      await prefs.setString("Role", json["data"]["Role"]);
      widget.ServiceID = prefs.getString("ServiceID") == "null"
          ? null
          : prefs.getString("ServiceID");
    }

    return json;
  }

  Future<dynamic> plumberApproveStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.apiKey2 = prefs.getString("apikey")!;
    var apiURL = "https://cqpplefitting.com/ad_cqpple/Api/IsServiceManApprove";
    Map map = {};

    map["apikey"] = widget.apiKey2;
    map["ApplicationUserID"] =
        widget.mobileNumberResponse["data"]["ApplicationUserID"];
    prefs.setString("ApplicationUserID", map["ApplicationUserID"]);
    print(map);
    var response = await http.post(Uri.parse(apiURL), body: jsonEncode(map));
    print(response.statusCode);
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  Future<dynamic> requestForOTP() async {
    widget.isLoading = true;
    var apiURL = "https://cqpplefitting.com/ad_cqpple/Api/login";
    Map<String, String> map = {};
    map["apikey"] = widget.apiKey;
    map["ContactNumber"] = widget.mobile_number;
    var response = await http.post(Uri.parse(apiURL), body: jsonEncode(map));
    widget.isLoading = false;
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  Future<void> _resendCode() async {
    await requestForOTP();
    //other code here
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }
}
