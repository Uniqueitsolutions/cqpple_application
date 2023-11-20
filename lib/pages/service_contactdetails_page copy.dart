import 'dart:convert';
import 'dart:math';

import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/custom/custom_loader.dart';
import 'package:bath_service_project/custom/internet_checking.dart';
import 'package:bath_service_project/models/pincode_info.dart';
import 'package:bath_service_project/pages/service_request_page.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:searchfield/searchfield.dart';
import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/customappbar.dart';

class ServiceContactDetails1 extends StatefulWidget {
  String mobile_number = "";

  String apikey = "";
  ServiceContactDetails1(String mobile_number, {super.key}) {
    this.mobile_number = mobile_number;
  }

  bool isLoading = false;
  bool flagForStateLoader = true;

  @override
  State<ServiceContactDetails1> createState() => _ServiceContactDetailsState();
}

class _ServiceContactDetailsState extends State<ServiceContactDetails1> {
  final _formKey = GlobalKey<FormState>();
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

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(top: 3, left: 15),
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(
        color: const Color.fromRGBO(181, 181, 181, 1),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      fillColor: const Color.fromRGBO(246, 246, 246, 1),
      filled: true,
    );
  }

  final fieldTextStyle = GoogleFonts.poppins(
    color: const Color.fromRGBO(0, 0, 0, 1),
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  final titleTextStyle = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    // TODO: implement initState
    phoneNumberController.text = widget.mobile_number;
    whatsappNumberController.text = widget.mobile_number;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var firstNamecontainer = Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: nameController,
        validator: (value) {
          if (value == null || value == "") {
            return "* Please Enter First Name";
          }
          return null;
        },
        decoration: inputDecoration("Please Enter Your Name"),
        style: fieldTextStyle,
      ),
    );

    var addressContainer = Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: addressController,
        validator: (value) {
          if (value == null || value == "") {
            return "* Please Enter Address";
          }
          return null;
        },
        decoration: inputDecoration("Please Enter Your Address"),
        style: fieldTextStyle,
      ),
    );

    var pincodeContainer = Container(
      margin: const EdgeInsets.only(top: 10),
      // height: 50,
      child: TextFormField(
        controller: pincodeController,
        validator: (value) {
          RegExp regex = RegExp("[0-9]{6}");
          bool match = regex.hasMatch(value.toString());
          if (value == null || value == "") {
            return "* Please Enter Pincode";
          }
          if (!match) {
            return "* Please Enter 6 Digit Pincode";
          }
          return null;
        },
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: inputDecoration("Please Enter Your Pincode"),
        style: fieldTextStyle,
        onFieldSubmitted: ((value) {
          fetchAddressFromPincode(value);
        }),
      ),
    );

    var stateContainer = Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: stateController,
        validator: (value) {
          if (value == null || value == "") {
            return "* Please Enter State";
          }
          return null;
        },
        decoration: inputDecoration("State"),
        style: fieldTextStyle,
      ),
    );

    var cityContainer = Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: cityController,
        validator: (value) {
          if (value == null || value == "") {
            return "* Please Enter City";
          }
          return null;
        },
        decoration: inputDecoration("City"),
        style: fieldTextStyle,
      ),
    );

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
                                style: titleTextStyle,
                              ),
                              firstNamecontainer,
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Text("Enter Address",
                                    style: titleTextStyle),
                              ),
                              addressContainer,
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "Enter Pincode",
                                  style: titleTextStyle,
                                ),
                              ),
                              pincodeContainer,
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("State", style: titleTextStyle),
                                        stateContainer,
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("City", style: titleTextStyle),
                                        cityContainer,
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              /*
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text("State", style: titleTextStyle),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "City",
                                        style: titleTextStyle,
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
                                              widget.isLoading = false;
                                              List<String> stateNameList =
                                                  snapshot.data!.map((e) {
                                                return e["name"].toString();
                                              }).toList();

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
                                                  child: widget
                                                          .flagForStateLoader
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
                                            widget.isLoading = false;
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
                                                  child: widget
                                                          .flagForStateLoader
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
                              Container(
                                child: Row(
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
                              ),
                              */
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
                                        validator: (value) {
                                          RegExp regex = RegExp(
                                              "^(?:(?:\\+|0{0,2})91(\\s*[\\-]\\s*)?|[0]?)?[789]\\d{9}\$");
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
                                          RegExp regex = RegExp(
                                              "^(?:(?:\\+|0{0,2})91(\\s*[\\-]\\s*)?|[0]?)?[789]\\d{9}\$");
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
                                          pincodeController.text.toString();
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
        drawer: const CustomDrawer(),
        // resizeToAvoidBottomInset: false,
      ),
    );
  }

  Future<List<Map<String, String>>> getStates() async {
    // widget.isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.apikey = prefs.getString("apikey")!;
    String apiURL =
        "https://cqpplefitting.com/ad_cqpple/Api/State/${widget.apikey}";
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.apikey = prefs.getString("apikey")!;
    String apiURL =
        "https://cqpplefitting.com/ad_cqpple/Api/City/${widget.apikey}/$selectedStateID";
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
    widget.isLoading = false;
    isGetCities = true;
    return cityList;
  }

  void fetchAddressFromPincode(String pincode) {
    String apiURL = "https://api.postalpincode.in/pincode//$pincode";
    http.get(Uri.parse(apiURL)).then((res) {
      List array = jsonDecode(res.body);
      Map<String, dynamic> response = array.first;
      String status = response["Status"];
      if (status == "Success") {
        List postOffices = response["PostOffice"];
        var firstObject = postOffices.first;
        var info = PincodeInfo.fromJson(firstObject);
        cityController.text = info.block ?? "";
        stateController.text = info.state ?? "";
      } else {
        print("No record found");
      }
    });
  }
}
