import 'dart:convert';

import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/models/api_base_array_response.dart';
import 'package:bath_service_project/models/plumber_service.dart';
import 'package:bath_service_project/pages/plumber_servicedetails_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cells/plumber_service_cell.dart';
import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/custom_textstyle.dart';
import '../custom/customappbar.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class PlumberServiceTokenPage extends StatefulWidget {
  PlumberServiceTokenPage({super.key});
  var apiKey = "";
  List<PlumberService> services = [];
  @override
  State<PlumberServiceTokenPage> createState() =>
      _PlumberServiceTokenPageState();
}

class _PlumberServiceTokenPageState extends State<PlumberServiceTokenPage> {
  final complainNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TextField
    var textFormField = Expanded(
      child: TextFormField(
        controller: tokenController,
        validator: (value) {
          if (value == null || value == "") {
            return "* Please Enter Token";
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: "EG : ABSX",
          hintStyle: GoogleFonts.poppins(
              color: const Color.fromRGBO(181, 181, 181, 1),
              fontSize: 16,
              fontWeight: FontWeight.w500),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          fillColor: const Color.fromRGBO(246, 246, 246, 1),
          filled: true,
        ),
        style: GoogleFonts.poppins(
            color: const Color.fromRGBO(0, 0, 0, 1),
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
    );

    // Button
    var submitButton = ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return PlumberServiceDetailsPage(
                  complainNumber: tokenController.text.toString(),
                );
              },
            ));
          }
        },
        child: const Text("Submit"));

    var listView = ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: widget.services.length,
      itemBuilder: (context, index) {
        var service = widget.services[index];
        return ServiceListCell(
          plumberService: service,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return PlumberServiceDetailsPage(
                  complainNumber: service.complainNumber ?? "",
                );
              },
            ));
          },
        );
      },
    );

    var container = Container(
      margin: const EdgeInsets.only(top: 160),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          color: Color.fromARGB(255, 242, 242, 242)),
      height: MediaQuery.of(context).size.height - 188,
      child: Container(
        margin: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextStyle(
                  title: "Service Token",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textFormField,
                    const SizedBox(width: 20),
                    submitButton,
                  ],
                ),
              ),
              Expanded(child: listView),
            ],
          ),
        ),
      ),
    );

    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            drawer: CustomDrawer(),
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                CustomAppBar(
                  title1: "",
                  title2: "Plumber Service",
                ),
                container,
                Builder(builder: (context) {
                  return TextButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      child: const CustomIcon());
                }),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }

  @override
  void initState() {
    super.initState();
    fetchPendingServices();
  }

  Future<dynamic> requestForOTP() async {
    var apiURL =
        "https://cqpplefitting.com/ad_cqpple/Api/ServiceByComplainNumber";
    Map<String, String> map = {};

    map["apikey"] = widget.apiKey;
    map["ComplainNumber"] = complainNumberController.text.toString();
    if (kDebugMode) {
      print(widget.apiKey);
    }
    var response = await http.post(Uri.parse(apiURL), body: jsonEncode(map));
    return response.body;
  }

  Future<void> fetchPendingServices() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    widget.apiKey = pref.getString("apikey")!;
    const apiURL =
        "https://cqpplefitting.com/ad_cqpple/Api/ServiceByPlumberApiToken";
    var requestBody = "apikey=${Uri.encodeComponent(widget.apiKey)}";
    var headers = {"Content-Type": "application/x-www-form-urlencoded"};
    var response =
        await http.post(Uri.parse(apiURL), body: requestBody, headers: headers);
    var data = json.decode(response.body);
    ArrayResponse<PlumberService> arrayResponse =
        ArrayResponse<PlumberService>.fromJson(
            data, (dynamic json) => PlumberService.fromJson(json));
    setState(() {
      widget.services = arrayResponse.data;
    });
  }
}
