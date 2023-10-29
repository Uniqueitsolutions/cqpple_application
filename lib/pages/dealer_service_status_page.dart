import 'dart:convert';
import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/custom/custom_loader.dart';
import 'package:bath_service_project/custom/internet_checking.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/customappbar.dart';

class DealerServiceStatusPage extends StatefulWidget {
  var apikey = "";
  List listOfStatus = [
    {"name": "Service Add", "date": ""},
    {"name": "Approved by Admin", "date": ""},
    {"name": "Assign Plumber", "date": ""},
    {"name": "Completed", "date": ""},
    {"name": "Rejected", "date": ""}
  ];
  bool isServiceFound = true;
  String? ComplainNumber = "0";


  DealerServiceStatusPage({String? ServiceID}) {
    this.ComplainNumber = ServiceID;
  }

  @override
  State<DealerServiceStatusPage> createState() =>
      _DealerServiceStatusPageState();
}

class _DealerServiceStatusPageState extends State<DealerServiceStatusPage> {
  bool ratingButtonDisabled = true;

  bool colorFlag = false;
  int starRating = 0;
  dynamic starIcon1 = Icon(
    Icons.star_border_outlined,
    size: 28,
  );
  dynamic starIcon2 = Icon(Icons.star_border_outlined, size: 28);
  dynamic starIcon3 = Icon(Icons.star_border_outlined, size: 28);
  dynamic starIcon4 = Icon(Icons.star_border_outlined, size: 28);
  dynamic starIcon5 = Icon(Icons.star_border_outlined, size: 28);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
              InternetChecking(),
              CustomAppBar(
                title1: "",
                title2: "Service Status",
              ),
              Container(
                margin: EdgeInsets.only(top: 160),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height - 188,
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData && widget.isServiceFound) {

                      return SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  height: 130,
                                  margin: EdgeInsets.only(top: 20),
                                  width: MediaQuery.of(context).size.width - 50,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color:
                                          Color.fromRGBO(230, 230, 230, 0.25)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 20, left: 30),
                                        child: Text(
                                          snapshot.data!["Name"].toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              color: Color.fromRGBO(
                                                  29, 29, 29, 1)),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 8, left: 30),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 5),
                                                child: Text(
                                                  "Address :",
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.poppins(
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromRGBO(
                                                          29, 29, 29, 1)),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  snapshot.data!["Address"],
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.poppins(
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          181, 181, 181, 1)),
                                                ),
                                              ),
                                              flex: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 8, left: 30),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 5),
                                                child: Text(
                                                  "Mobile No. :",
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.poppins(
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromRGBO(
                                                          29, 29, 29, 1)),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Flexible(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  snapshot
                                                      .data!["WhatsappNumber"],
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.poppins(
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          181, 181, 181, 1)),
                                                ),
                                              ),
                                              flex: 3,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 25),
                                        child: Image.network(
                                            "https://cqpplefitting.com/ad_cqpple/Images/Problem/" +
                                                snapshot.data!["ProblemImage"]),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Container(
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Problem",
                                                style: GoogleFonts.poppins(
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        131, 131, 131, 1)),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 40),
                                                child: Text(
                                                  snapshot.data!["Problem"],
                                                  style: GoogleFonts.poppins(
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromRGBO(
                                                          29, 29, 29, 1)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Color.fromRGBO(
                                            230, 230, 230, 0.25)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomSteps(
                                            widget.listOfStatus[0]["name"],
                                            widget.listOfStatus[0]["date"],
                                            false),
                                        CustomSteps(
                                            widget.listOfStatus[1]["name"],
                                            widget.listOfStatus[1]["date"],
                                            false),
                                        CustomSteps(
                                            widget.listOfStatus[2]["name"],
                                            widget.listOfStatus[2]["date"],
                                            false),
                                        CustomSteps(
                                            widget.listOfStatus[3]["name"],
                                            widget.listOfStatus[3]["date"],
                                            false),
                                        Container(
                                            margin: EdgeInsets.only(bottom: 13),
                                            child: CustomSteps(
                                                widget.listOfStatus[4]["name"],
                                                widget.listOfStatus[4]["date"],
                                                false)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    else if(snapshot.hasError){
                      widget.isServiceFound=false;

                      return Container(
                        margin: EdgeInsets.only(top: 40,left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Icon(Icons.dangerous_outlined,size: 30,color: Color.fromRGBO(227, 59, 36, 1))),
                                Expanded(
                                  flex: 5,
                                  child: Text("Service Not Found",
                                    style: GoogleFonts.poppins(
                                        color: Color.fromRGBO(227, 59, 36, 1),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                )
                              ],
                            ),
                            CustomSubmitBotton(
                              title: "Exit",margin_top: 50,
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    else {
                      return CustomLoader();
                    }
                  },
                  future: getServiceStatus(),
                ),
              ),

              Builder(builder: (context){
                return TextButton( onPressed: () => Scaffold.of(context).openDrawer(), child: CustomIcon());
              }),
            ],
          ),
          drawer: CustomDrawer(),
          floatingActionButton: widget.isServiceFound?Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color.fromRGBO(24, 83, 201, 1),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: TextButton(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ):Container(),
      ),
    );
  }

  Widget CustomSteps(String text, String datetime, bool flag) {
    if (datetime != "") {
      flag = true;
    }
    return Container(
      margin: EdgeInsets.only(top: 10, left: 30),
      child: Row(
        children: [
          Flexible(
              child: flag
                  ? Image.asset("assets/images/GreenVector.png")
                  : Image.asset(
                      "assets/images/Vector.png",
                      height: 20,
                      width: 20,
                    )),
          Flexible(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: flag
                            ? Colors.green
                            : Color.fromRGBO(212, 212, 212, 1)),
                  ),
                  datetime == ""
                      ? Container()
                      : Text(
                          datetime,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(163, 163, 163, 1)),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map> getServiceStatus() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.apikey = await prefs.getString("apikey")!;
    var apiURL =
        "https://cqpplefitting.com/ad_cqpple/Api/ServiceStatusByComplainNumber";
    Map map = {};
    map["apikey"] = widget.apikey;
    map["ComplainNumber"] = widget.ComplainNumber;
    var response = await http.post(Uri.parse(apiURL), body: jsonEncode(map));
    var responseBody = await jsonDecode(response.body);
    var responseData = responseBody["data"][0];

    if (responseData != {}) {
      List listStatusResponse = responseData["status_history"];
      for (int i = 0; i < listStatusResponse.length; i++) {
        widget.listOfStatus[listStatusResponse[i]["StatusID"] - 1]["name"] =
            listStatusResponse[i]["Status"] + "  ";
        widget.listOfStatus[listStatusResponse[i]["StatusID"] - 1]["date"] =
            "On " + listStatusResponse[i]["Date"].split(".")[0].toString();
      }
    }
    print(responseData);

    return responseData;
  }
}
