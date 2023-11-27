import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/custom/custom_textstyle.dart';
import 'package:bath_service_project/custom/internet_checking.dart';
import 'package:bath_service_project/pages/dealer_service_status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/customappbar.dart';

class DealerLoginPage extends StatefulWidget {
  const DealerLoginPage({super.key});

  @override
  State<DealerLoginPage> createState() => _DealerLoginPageState();
}

class _DealerLoginPageState extends State<DealerLoginPage> {
  final _formKey = GlobalKey<FormState>();
  var serviceIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              InternetChecking(),
              CustomAppBar(
                title1: "",
                title2: "Dealer Login",
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 160),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height - 188,
                    child: Container(
                      margin: const EdgeInsets.only(left: 33, right: 33, top: 40),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextStyle(
                                title: "Complain Number",
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: serviceIDController,
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "* Please Enter Complain Complain";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Please Enter Complain Number",
                                    hintStyle: GoogleFonts.poppins(
                                        color: Color.fromRGBO(181, 181, 181, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    fillColor: Color.fromRGBO(246, 246, 246, 1),
                                    filled: true,
                                  ),
                                  style: GoogleFonts.poppins(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Enter the service number for details.",
                                  style: GoogleFonts.poppins(
                                    color: Color.fromRGBO(114, 114, 114, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              CustomSubmitBotton(
                                title: "Submit",
                                margin_top: 50,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) {
                                        return DealerServiceStatusPage(
                                          ServiceID:
                                              serviceIDController.text.toString(),
                                        );
                                      },
                                    ));
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Builder(builder: (context){
                return TextButton( onPressed: () => Scaffold.of(context).openDrawer(), child: CustomIcon());
              }),
            ],
          ),
          drawer: CustomDrawer(),
          resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }
}
