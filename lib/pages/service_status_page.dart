import 'dart:convert';

import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/custom/custom_loader.dart';
import 'package:bath_service_project/custom/internet_checking.dart';
import 'package:bath_service_project/pages/homescreen_page.dart';
import 'package:bath_service_project/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/customappbar.dart';

class ServiceStatusPage extends StatefulWidget {
  var apikey = "";
  List listOfStatus = [
    {"name": "Service Add", "date": ""},
    {"name": "Approved by Admin", "date": ""},
    {"name": "Assign Plumber", "date": ""},
    {"name": "Completed", "date": ""},
    {"name": "Rejected", "date": ""}
  ];
  String? ServiceID = "0";
  bool isSnakebar = true;
  bool isLoading = false;
  ServiceStatusPage({super.key, String? ServiceID}) {
    this.ServiceID = ServiceID;
  }

  @override
  State<ServiceStatusPage> createState() => _ServiceStatusPageState();
}

class _ServiceStatusPageState extends State<ServiceStatusPage> {
  bool isServiceGet = true;
  bool ratingButtonDisabled = true;
  bool isLogoutAvailable = false;
  bool colorFlag = false;
  int starRating = 0;
  dynamic starIcon1 = const Icon(
    Icons.star_border_outlined,
    size: 28,
  );
  dynamic starIcon2 = const Icon(Icons.star_border_outlined, size: 28);
  dynamic starIcon3 = const Icon(Icons.star_border_outlined, size: 28);
  dynamic starIcon4 = const Icon(Icons.star_border_outlined, size: 28);
  dynamic starIcon5 = const Icon(Icons.star_border_outlined, size: 28);

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
                  title2: "Service Status",
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
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        isServiceGet = false;
                        return SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 50),
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Color.fromRGBO(
                                            230, 230, 230, 0.25)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 20, left: 30),
                                          child: Text(
                                            "#${snapshot.data!["ComplainNumber"].toString()}",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.normal,
                                                color: const Color.fromRGBO(
                                                    29, 29, 29, 1)),
                                          ),
                                        ),
                                        getTitleDetailsView(
                                            "Name", snapshot.data!["Name"]),
                                        getTitleDetailsView("Address",
                                            "${snapshot.data!["Address"]}, ${snapshot.data!["cityname"]}, ${snapshot.data!["statename"]}"),
                                        getTitleDetailsView("Pincode",
                                            snapshot.data!["Pincode"]),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 8, left: 30),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  child: Text(
                                                    "Mobile No. :",
                                                    textAlign: TextAlign.end,
                                                    style: GoogleFonts.poppins(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color
                                                            .fromRGBO(
                                                            29, 29, 29, 1)),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5),
                                                  child: Text(
                                                    snapshot.data![
                                                        "WhatsappNumber"],
                                                    textAlign: TextAlign.start,
                                                    style: GoogleFonts.poppins(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color
                                                            .fromRGBO(
                                                            181, 181, 181, 1)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 25),
                                          child: Image.network(
                                              "https://cqpplefitting.com/ad_cqpple/Images/Problem/" +
                                                  snapshot
                                                      .data!["ProblemImage"]),
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
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          const Color.fromRGBO(
                                                              131,
                                                              131,
                                                              131,
                                                              1)),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 40),
                                                  child: Text(
                                                    snapshot.data!["Problem"],
                                                    style: GoogleFonts.poppins(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color
                                                            .fromRGBO(
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
                                  margin: const EdgeInsets.only(top: 20),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Center(
                                    child: Container(
                                      decoration: const BoxDecoration(
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
                                              margin: const EdgeInsets.only(
                                                  bottom: 13),
                                              child: CustomSteps(
                                                  widget.listOfStatus[4]
                                                      ["name"],
                                                  widget.listOfStatus[4]
                                                      ["date"],
                                                  false)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                widget.listOfStatus[3]["date"] != "" ||
                                        widget.listOfStatus[4]["date"] != ""
                                    ? Center(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 15),
                                          child: Text("Rate Our Service",
                                              style: GoogleFonts.poppins(
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color.fromRGBO(
                                                      29, 29, 29, 1))),
                                        ),
                                      )
                                    : Container(),
                                widget.listOfStatus[3]["date"] != "" ||
                                        widget.listOfStatus[4]["date"] != ""
                                    ? Center(
                                        child: SizedBox(
                                          width: 140,
                                          child: Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      starRating = 1;
                                                      starIcon1 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon2 = const Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          size: 28);
                                                      starIcon3 = const Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          size: 28);
                                                      starIcon4 = const Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          size: 28);
                                                      starIcon5 = const Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          size: 28);
                                                    });
                                                  },
                                                  child: starIcon1),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      starRating = 2;
                                                      starIcon1 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon2 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon3 = const Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          size: 28);
                                                      starIcon4 = const Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          size: 28);
                                                      starIcon5 = const Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          size: 28);
                                                    });
                                                  },
                                                  child: starIcon2),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      starRating = 3;
                                                      starIcon1 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon2 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon3 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon4 = const Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          size: 28);
                                                      starIcon5 = const Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          size: 28);
                                                    });
                                                  },
                                                  child: starIcon3),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      starRating = 4;
                                                      starIcon1 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon2 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon3 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon4 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon5 = const Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          size: 28);
                                                    });
                                                  },
                                                  child: starIcon4),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      starRating = 5;
                                                      starIcon1 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon2 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon3 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon4 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                      starIcon5 = const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 28);
                                                    });
                                                  },
                                                  child: starIcon5),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                                widget.listOfStatus[3]["date"] != "" ||
                                        widget.listOfStatus[4]["date"] != ""
                                    ? CustomSubmitBotton(
                                        title: "Submit",
                                        margin_top: 20,
                                        margin_bottom: 20,
                                        onTap: () async {
                                          await postStarRating();
                                          SharedPreferences pref =
                                              await SharedPreferences
                                                  .getInstance();
                                          await pref.setString(
                                              "ServiceID", "null");
                                          widget.isLoading = false;
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return const HomeScreenPage();
                                            },
                                          ));
                                        },
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return CustomLoader();
                      }
                    },
                    future: isServiceGet ? getServiceStatus() : null,
                  ),
                ),
                widget.isLoading ? CustomLoader() : Container(),
                Builder(builder: (context) {
                  return TextButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      child: const CustomIcon());
                }),
              ],
            ),
            drawer: CustomDrawer(),
          ),
        ));
  }

  Widget CustomSteps(String text, String datetime, bool flag) {
    if (datetime != "") {
      flag = true;
    }
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 30),
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
              margin: const EdgeInsets.only(left: 20, right: 15),
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
                            : const Color.fromRGBO(212, 212, 212, 1)),
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
                              color: const Color.fromRGBO(163, 163, 163, 1)),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitleDetailsView(String title, String details) {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(
              "$title :",
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(29, 29, 29, 1)),
            ),
          ),
          Flexible(
            child: Text(
              details,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(181, 181, 181, 1)),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map> getServiceStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.apikey = prefs.getString("apikey")!;
    var apiURL =
        "https://cqpplefitting.com/ad_cqpple/Api/ServiceStatusByServiceID";
    Map map = {};
    map["apikey"] = widget.apikey;
    map["ServiceID"] = widget.ServiceID;
    var response = await http.post(Uri.parse(apiURL), body: jsonEncode(map));
    print(response.body);
    var responseData = await jsonDecode(response.body)["data"][0];
    List listStatusResponse = responseData["status_history"];
    for (int i = 0; i < listStatusResponse.length; i++) {
      widget.listOfStatus[listStatusResponse[i]["StatusID"] - 1]["name"] =
          listStatusResponse[i]["Status"] + "  ";
      widget.listOfStatus[listStatusResponse[i]["StatusID"] - 1]["date"] =
          "On ${listStatusResponse[i]["Date"].split(".")[0]}";
    }
    if (widget.listOfStatus[3]["date"] != "" ||
        widget.listOfStatus[4]["date"] != "") {
      setState(() {
        isLogoutAvailable = false;
      });
    } else {
      setState(() {
        isLogoutAvailable = true;
      });
    }
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    await prefs2.setString("ServiceID", widget.ServiceID!);
    prefs2.setBool("isLogoutAvailable", isLogoutAvailable);

    return responseData;
  }

  Future<void> postStarRating() async {
    widget.isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.apikey = prefs.getString("apikey")!;
    var apiURL = "https://cqpplefitting.com/ad_cqpple/Api/AddRating";
    Map map = {};
    map["apikey"] = widget.apikey;
    map["ServiceID"] = widget.ServiceID;
    map["RatingID"] = starRating.toString();
    var response = await http.post(Uri.parse(apiURL), body: jsonEncode(map));
    print(response);
  }
}
