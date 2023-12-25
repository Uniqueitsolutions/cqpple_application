import 'dart:convert';
import 'package:bath_service_project/Utils/helper.dart';
import 'package:bath_service_project/Utils/preference.dart';
import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/custom/internet_checking.dart';
import 'package:bath_service_project/pages/service_request_page.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:searchfield/searchfield.dart';
import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/customappbar.dart';

class ServiceContactDetails extends StatefulWidget {
  final String mobileNumber;
  const ServiceContactDetails(this.mobileNumber, {super.key});
  @override
  State<ServiceContactDetails> createState() => _ServiceContactDetailsState();
}

class _ServiceContactDetailsState extends State<ServiceContactDetails> {
  final _formKey = GlobalKey<FormState>();
  final apikey = PreferencesManager.getAPIKey();
  bool isLoading = false;
  bool flagForStateLoader = true;
  String dropdownvalueForState = 'Select State';
  bool flagForStateDropDown = true;

  String dropdownvalueForCity = "Select City";
  bool flagForCityDropDown = true;
  String selectedStateID = "";
  String selectedCityID = "";
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var pincodeController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var whatsappNumberController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var isStateChange = true;

  bool isGetCities = false;
  bool cityValidator = false;
  bool stateValidator = false;
  UserRole? userRole = PreferencesManager.getRole();

  @override
  void initState() {
    if (userRole == UserRole.plumber) {
      phoneNumberController.text = widget.mobileNumber;
      whatsappNumberController.text = widget.mobileNumber;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const InternetChecking(),
            CustomAppBar(
              title1: "",
              title2: "Contact Details",
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
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
                              left: 33, right: 33, top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enter Name",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "* Please Enter First Name";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(top: 3, left: 15),
                                    hintText: "Please Enter Your Name",
                                    hintStyle: GoogleFonts.poppins(
                                        color: const Color.fromRGBO(
                                            181, 181, 181, 1),
                                        fontSize: 14,
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
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "Enter Address",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: addressController,
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "* Please Enter Address";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(top: 3, left: 15),
                                    hintText: "Please Enter Your Address",
                                    hintStyle: GoogleFonts.poppins(
                                        color: const Color.fromRGBO(
                                            181, 181, 181, 1),
                                        fontSize: 14,
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
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "Enter Pincode",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                // height: 50,
                                child: TextFormField(
                                  controller: pincodeController,
                                  validator: (value) {
                                    RegExp regex = RegExp("[0-9]{6}");
                                    bool match =
                                        regex.hasMatch(value.toString());
                                    if (value == null || value == "") {
                                      return "* Please Enter Pincode";
                                    }
                                    if (!match) {
                                      return "* Please Enter 6 Digit Pincode";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(top: 3, left: 15),
                                    hintText: "Please Enter Your Pincode",
                                    hintStyle: GoogleFonts.poppins(
                                        color: const Color.fromRGBO(
                                            181, 181, 181, 1),
                                        fontSize: 14,
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
                              Container(
                                margin: const EdgeInsets.only(top: 20, left: 3),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            "State",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          // Container(
                                          //   margin: EdgeInsets.only(left: 20),
                                          //   height: 20,
                                          //   width: 20,
                                          //   child: widget.flagForStateLoader? CircularProgressIndicator():Container(),
                                          // )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "City",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 50,
                                      child: Card(
                                        color: const Color.fromRGBO(
                                            246, 246, 246, 1),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: Colors.black45,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              8.0), //<-- SEE HERE
                                        ),
                                        child: FutureBuilder(
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              isLoading = false;

                                              if (flagForStateDropDown) {
                                                selectedStateID = snapshot
                                                    .data![0]["id"]
                                                    .toString();
                                                flagForStateDropDown = false;
                                              }
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5),
                                                child: DropDownTextField(
                                                    validator: (value) {
                                                      if (value.toString() ==
                                                          "") {
                                                        setState(() {
                                                          stateValidator = true;
                                                        });
                                                        return null;
                                                      }
                                                      setState(() {
                                                        stateValidator = false;
                                                      });
                                                      return null;
                                                    },
                                                    // controller: stateController,
                                                    searchAutofocus: true,
                                                    dropdownRadius: 5,
                                                    listTextStyle:
                                                        GoogleFonts.poppins(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                    textStyle:
                                                        GoogleFonts.poppins(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                    textFieldDecoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                "Select State"),
                                                    enableSearch: true,
                                                    listPadding:
                                                        ListPadding(top: 5),
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        selectedStateID =
                                                            newValue!.value;
                                                        flagForCityDropDown =
                                                            true;
                                                        isStateChange = false;
                                                        isGetCities = false;
                                                      });
                                                    },
                                                    dropDownList:
                                                        snapshot.data!.map(
                                                      (Map item) {
                                                        return DropDownValueModel(
                                                            name: item["name"]
                                                                .toString(),
                                                            value: item["id"]
                                                                .toString());
                                                      },
                                                    ).toList()),
                                              );
                                            } else {
                                              return Center(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 20),
                                                  height: 20,
                                                  width: 20,
                                                  child: flagForStateLoader
                                                      ? const CircularProgressIndicator()
                                                      : Container(),
                                                ),
                                              );
                                            }
                                          },
                                          future: flagForStateDropDown
                                              ? getStates()
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.transparent,
                                      // margin: const EdgeInsets.only(left: 25,right: 25,top: 5),
                                      height: 50,
                                      child: Card(
                                        color: const Color.fromRGBO(
                                            246, 246, 246, 1),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: Colors.black45,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              8.0), //<-- SEE HERE
                                        ),
                                        child: FutureBuilder(
                                          builder: (context, snapshot2) {
                                            isLoading = false;
                                            if (snapshot2.hasData &&
                                                isGetCities) {
                                              if (flagForCityDropDown) {
                                                flagForCityDropDown = false;
                                              }
                                              return Center(
                                                child: Container(
                                                  width: 200,
                                                  margin: const EdgeInsets.only(
                                                      left: 5),
                                                  child: DropDownTextField(
                                                    validator: (value) {
                                                      if (value.toString() ==
                                                          "") {
                                                        setState(() {
                                                          cityValidator = true;
                                                        });
                                                        return null;
                                                      }
                                                      setState(() {
                                                        cityValidator = false;
                                                      });
                                                      return null;
                                                    },
                                                    // controller: cityController,
                                                    searchAutofocus: true,
                                                    dropdownRadius: 5,
                                                    listTextStyle:
                                                        GoogleFonts.poppins(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                    textStyle:
                                                        GoogleFonts.poppins(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                    textFieldDecoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                "Select City"),
                                                    enableSearch: true,
                                                    listPadding:
                                                        ListPadding(top: 5),
                                                    dropDownList: snapshot2
                                                        .data!
                                                        .map((Map item) {
                                                      return DropDownValueModel(
                                                          name: item["name"],
                                                          value: item["id"]);
                                                    }).toList(),
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        selectedCityID =
                                                            newValue.value!
                                                                .toString();
                                                        flagForCityDropDown =
                                                            false;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 20),
                                                  height: 20,
                                                  width: 20,
                                                  child: flagForStateLoader
                                                      ? const CircularProgressIndicator()
                                                      : Container(),
                                                ),
                                              );
                                            }
                                          },
                                          future:
                                              !isGetCities ? getCities() : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: stateValidator
                                        ? Text(
                                            "* Select State",
                                            style: GoogleFonts.poppins(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  Expanded(
                                    child: cityValidator
                                        ? Text(
                                            "* Select City",
                                            style: GoogleFonts.poppins(
                                              color: Colors.redAccent,
                                              fontSize: 12,
                                            ),
                                          )
                                        : Container(),
                                  ),
                                ],
                              ),
                              const Text(
                                "* This information will help up to reach at your address",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15, left: 3),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Phone",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Whatsapp",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 5, top: 5),
                                      // height: 45,
                                      child: TextFormField(
                                        controller: phoneNumberController,
                                        onEditingComplete: () {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          whatsappNumberController.text =
                                              phoneNumberController.text;
                                        },
                                        validator: (value) {
                                          RegExp regex =
                                              Helper.mobileNumberRegExp();
                                          bool match =
                                              regex.hasMatch(value.toString());
                                          if (value == null || value == "") {
                                            return "Please Enter\n Phone Number";
                                          }
                                          if (!match) {
                                            return "Pleas Enter Valid\n Phone Number";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              top: 3, left: 15),
                                          hintText: "1234567890",
                                          hintStyle: GoogleFonts.poppins(
                                              color: const Color.fromRGBO(
                                                  181, 181, 181, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          fillColor: const Color.fromRGBO(
                                              246, 246, 246, 1),
                                          filled: true,
                                        ),
                                        style: GoogleFonts.poppins(
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 5, top: 5),
                                      child: TextFormField(
                                        controller: whatsappNumberController,
                                        validator: (value) {
                                          RegExp regex =
                                              Helper.mobileNumberRegExp();
                                          bool match =
                                              regex.hasMatch(value.toString());
                                          if (value == null || value == "") {
                                            return "Please Enter\n Whatsapp Number";
                                          }
                                          if (!match) {
                                            return "Pleas Enter Valid\n Whatsapp Number";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              top: 3, left: 15),
                                          hintText: "1234567890",
                                          hintStyle: GoogleFonts.poppins(
                                              color: const Color.fromRGBO(
                                                  181, 181, 181, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          fillColor: const Color.fromRGBO(
                                              246, 246, 246, 1),
                                          filled: true,
                                        ),
                                        style: GoogleFonts.poppins(
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 45,
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 5),
                                child: CustomSubmitBotton(
                                  title: "Next",
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      Map map = {};
                                      map["Name"] =
                                          nameController.text.toString();
                                      map["Address"] =
                                          addressController.text.toString();
                                      map["Pincode"] =
                                          pincodeController.text.toString();
                                      map["ContactNumber"] =
                                          phoneNumberController.text.toString();
                                      map["WhatsappNumber"] =
                                          whatsappNumberController.text
                                              .toString();
                                      map["CityID"] = selectedCityID;
                                      map["StateID"] = selectedStateID;
                                      // print(map);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          return ServiceRequestFormPage(
                                              data: map);
                                        },
                                      ));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
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
        drawer: CustomDrawer(),
        // resizeToAvoidBottomInset: false,
      ),
    );
  }

  Future<List<Map<String, String>>> getStates() async {
    // widget.isLoading = true;
    String apiURL = "https://cqpplefitting.com/ad_cqpple/Api/State/$apikey";
    var res = await http.get(Uri.parse(apiURL));
    List stateObjects = jsonDecode(res.body)["data"];
    List<Map<String, String>> stateList = [];
    for (int i = 0; i < stateObjects.length; i++) {
      Map<String, String> map = <String, String>{};
      map["id"] = stateObjects[i]["id"].toString();
      map["name"] = stateObjects[i]["name"].toString();
      stateList.add(map);
    }

    return stateList;
  }

  Future<List<Map<String, String>>> getCities() async {
    // widget.isLoading = true;

    String apiURL =
        "https://cqpplefitting.com/ad_cqpple/Api/City/$apikey/$selectedStateID";
    var res = await http.get(Uri.parse(apiURL));
    List cityObjects = jsonDecode(res.body)["data"];
    List<Map<String, String>> cityList = [];
    for (int i = 0; i < cityObjects.length; i++) {
      Map<String, String> map = <String, String>{};
      map["id"] = cityObjects[i]["id"].toString();
      map["name"] = cityObjects[i]["name"].toString();
      cityList.add(map);
    }
    flagForCityDropDown = true;
    isLoading = false;
    isGetCities = true;
    return cityList;
  }
}
