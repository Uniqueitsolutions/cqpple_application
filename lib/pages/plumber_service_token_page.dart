import 'dart:convert';

import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/pages/plumber_servicedetails_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/custom_textstyle.dart';
import '../custom/customappbar.dart';
import 'package:http/http.dart' as http;

class PlumberServiceTokenPage extends StatefulWidget {
   PlumberServiceTokenPage({super.key});

  String apiKey = "1234567890456";
  @override
  State<PlumberServiceTokenPage> createState() => _PlumberServiceTokenPageState();
}

class _PlumberServiceTokenPageState extends State<PlumberServiceTokenPage> {

  var ComplainNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var tokenController = TextEditingController();

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
              CustomAppBar(title1: "", title2: "Plumber Service",),
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
                        color: Colors.white
                    ),
                    height: MediaQuery.of(context).size.height-188,
                    child: Container(
                      margin: const EdgeInsets.only(left: 33,right: 33,top: 40),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextStyle(title: "Service Token",),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  controller: tokenController,
                                  validator: (value) {
                                    if (value == null || value=="") {
                                      return "* Please Enter Token";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "EG : ABSX",
                                    hintStyle: GoogleFonts.poppins(
                                        color: Color.fromRGBO(181, 181, 181, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)
                                    ), fillColor: Color.fromRGBO(246,246,246,1),
                                    filled: true,
                                  ),
                                  style: GoogleFonts.poppins(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              CustomSubmitBotton(title: "Submit",margin_top: 50,
                                onTap: () {
                                  if(_formKey.currentState!.validate()){
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) {
                                        return PlumberServiceDetailsPage(complainNumber: tokenController.text.toString(),);
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
  Future<dynamic> requestForOTP() async {
    var apiURL = "https://cqpplefitting.com/ad_cqpple/Api/ServiceByComplainNumber";
    Map<String,String> map={};
    SharedPreferences pref = await SharedPreferences.getInstance();
    widget.apiKey = await pref.getString("apikey")!;
    map["apikey"] = widget.apiKey;
    map["ComplainNumber"] = ComplainNumberController.text.toString();
    print(widget.apiKey);
    var response = await http.post(Uri.parse(apiURL),body: jsonEncode(map));
    return response.body;
  }
}
