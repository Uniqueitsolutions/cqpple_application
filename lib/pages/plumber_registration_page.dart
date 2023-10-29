import 'dart:convert';
import 'dart:math';
import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/custom/custom_loader.dart';
import 'package:bath_service_project/custom/internet_checking.dart';
import 'package:bath_service_project/pages/login_page.dart';
import 'package:bath_service_project/pages/plumber_notregistered_page.dart';
import 'package:bath_service_project/pages/service_request_page.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/customappbar.dart';

class PlumberRegistrationPage extends StatefulWidget {
  String mobile_number = "";
  // PlumberRegistrationPage(String mobile_number){
  //   this.mobile_number=mobile_number;
  // }

  bool flagForStateLoader = true;
  String apiKey = "1234567890";
  bool isLoading = false;
  @override
  State<PlumberRegistrationPage> createState() => _PlumberRegistrationPageState();
}

class _PlumberRegistrationPageState extends State<PlumberRegistrationPage> {

  final _formKey = GlobalKey<FormState>();
  String dropdownvalueForState = 'Select State';
  bool flagForStateDropDown = true;
  var isStateChange = true;
  String dropdownvalueForCity = "Select City";
  bool flagForCityDropDown = true;
  String selectedStateID = "4006";
  String selectedCityID = "";
  String apikey = "1234567890";
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var pincodeController = TextEditingController();
  var contactNumberController = TextEditingController();
  var whatsappNumberController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();

  bool isGetCities = false;
  bool cityValidator = false;
  bool stateValidator = false;
  @override
  void initState() {
    // TODO: implement initState
    contactNumberController.text=widget.mobile_number;
    whatsappNumberController.text=widget.mobile_number;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            InternetChecking(),
            CustomAppBar(
              title1: "Plumber",
              title2: "Registration Details",
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      height: MediaQuery.of(context).size.height - 188,
                      margin: EdgeInsets.only(top: 160),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          color: Colors.white),
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(left: 33, right: 33, top: 30),
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
                                margin: EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value == null || value=="") {
                                      return "* Please Enter First Name";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 3,left: 15),
                                    hintText: "Please Enter Your Name",
                                    hintStyle: GoogleFonts.poppins(
                                        color: Color.fromRGBO(181, 181, 181, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    fillColor: Color.fromRGBO(246, 246, 246, 1),
                                    filled: true,
                                  ),
                                  style: GoogleFonts.poppins(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "Enter Address",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: addressController,
                                  validator: (value) {
                                    if (value == null || value=="") {
                                      return "* Please Enter Address";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 3,left: 15),
                                    hintText: "Please Enter Your Address",
                                    hintStyle: GoogleFonts.poppins(
                                        color: Color.fromRGBO(181, 181, 181, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    fillColor: Color.fromRGBO(246, 246, 246, 1),
                                    filled: true,
                                  ),
                                  style: GoogleFonts.poppins(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "Enter Pincode",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                // height: 50,
                                child: TextFormField(
                                  controller: pincodeController,
                                  validator: (value) {
                                    RegExp regex = RegExp("[0-9]{6}");
                                    bool match= regex.hasMatch(value.toString());
                                    if (value == null || value=="") {
                                      return "* Please Enter Pincode";
                                    }
                                    if(!match){
                                      return "* Please Enter 6 Digit Pincode";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 3,left: 15),
                                    hintText: "Please Enter Your Pincode",
                                    hintStyle: GoogleFonts.poppins(
                                        color: Color.fromRGBO(181, 181, 181, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    fillColor: Color.fromRGBO(246, 246, 246, 1),
                                    filled: true,
                                  ),
                                  style: GoogleFonts.poppins(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20, left: 3),
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
                                        color: Color.fromRGBO(246, 246, 246, 1),
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
                                                selectedStateID = snapshot.data![0]
                                                ["id"]
                                                    .toString();
                                                flagForStateDropDown = false;
                                              }
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    left: 5),
                                                child: DropDownTextField(
                                                    validator: (value) {
                                                      if(value.toString()==""){

                                                        setState(() {
                                                          stateValidator=true;
                                                        });
                                                        return null;
                                                      }
                                                      setState(() {
                                                        stateValidator=false;
                                                      });
                                                      return null;
                                                    },
                                                    // controller: stateController,
                                                    searchAutofocus: true,
                                                    dropdownRadius: 5,
                                                    listTextStyle: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                    textStyle: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                    textFieldDecoration:
                                                    InputDecoration(
                                                        hintText:
                                                        "Select State"),
                                                    enableSearch: true,
                                                    listPadding: ListPadding(
                                                        top:5
                                                    ),

                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        selectedStateID = newValue!.value;
                                                        flagForCityDropDown = true;
                                                        isStateChange=false;
                                                        isGetCities=false;
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
                                                  margin: EdgeInsets.only(left: 20),
                                                  height: 20,
                                                  width: 20,
                                                  child: widget.flagForStateLoader
                                                      ? CircularProgressIndicator()
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
                                        color: Color.fromRGBO(246, 246, 246, 1),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: Colors.black45,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              8.0), //<-- SEE HERE
                                        ),
                                        child: FutureBuilder(
                                          builder: (context, snapshot2) {
                                            widget.isLoading=false;
                                            if (snapshot2.hasData && isGetCities) {
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

                                                      if(value.toString()==""){
                                                        setState(() {
                                                          cityValidator=true;
                                                        });
                                                        return null;

                                                      }
                                                      setState(() {
                                                        cityValidator=false;
                                                      });
                                                      return null;
                                                    },
                                                    // controller: cityController,
                                                    searchAutofocus: true,
                                                    dropdownRadius: 5,
                                                    listTextStyle: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                    textStyle: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                    textFieldDecoration:
                                                    InputDecoration(
                                                        hintText:
                                                        "Select City"),
                                                    enableSearch: true,
                                                    listPadding: ListPadding(
                                                        top:5
                                                    ),
                                                    dropDownList: snapshot2.data!
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

                                                        flagForCityDropDown=false;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 20),
                                                  height: 20,
                                                  width: 20,
                                                  child: widget.flagForStateLoader
                                                      ? CircularProgressIndicator()
                                                      : Container(),
                                                ),
                                              );
                                            }
                                          },
                                          future: !isGetCities
                                              ? getCities()
                                              : null,
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
                                      child: stateValidator ? Text(
                                        "* Select State",
                                        style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ):Container(),
                                    ),
                                    Expanded(
                                      child: cityValidator ? Text(
                                        "* Select City",
                                        style: GoogleFonts.poppins(
                                          color: Colors.redAccent,
                                          fontSize: 12,
                                        ),
                                      ):Container(),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15, left: 3),
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
                                      margin: EdgeInsets.only(right: 5, top: 5),
                                      // height: 45,
                                      child: TextFormField(
                                        controller: contactNumberController,
                                        validator: (value) {
                                          RegExp regex = RegExp("^(?:(?:\\+|0{0,2})91(\\s*[\\-]\\s*)?|[0]?)?[789]\\d{9}\$");
                                          bool match= regex.hasMatch(value.toString());
                                          if (value == null || value=="") {
                                            return "Please Enter\n Phone Number";
                                          }
                                          if(!match){
                                            return "Pleas Enter Valid\n Phone Number";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(top: 3,left: 15),
                                          hintText: "9970937389",
                                          hintStyle: GoogleFonts.poppins(
                                              color:
                                              Color.fromRGBO(181, 181, 181, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(8)),
                                          fillColor:
                                          Color.fromRGBO(246, 246, 246, 1),
                                          filled: true,
                                        ),
                                        style: GoogleFonts.poppins(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 5, top: 5),
                                      child: TextFormField(
                                        controller: whatsappNumberController,
                                        validator: (value) {
                                          RegExp regex = RegExp("^(?:(?:\\+|0{0,2})91(\\s*[\\-]\\s*)?|[0]?)?[789]\\d{9}\$");
                                          bool match= regex.hasMatch(value.toString());
                                          if (value == null || value=="") {
                                            return "Please Enter\n Whatsapp Number";
                                          }
                                          if(!match){
                                            return "Pleas Enter Valid\n Whatsapp Number";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(top: 3,left: 15),
                                          hintText: "9970937389",
                                          hintStyle: GoogleFonts.poppins(
                                              color: Color.fromRGBO(181, 181, 181, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8)),
                                          fillColor: Color.fromRGBO(246, 246, 246, 1),
                                          filled: true,
                                        ),
                                        style: GoogleFonts.poppins(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 45,
                                margin: EdgeInsets.only(top: 20, bottom: 5),
                                child: CustomSubmitBotton(
                                  title: "Next",
                                  onTap: () async {
                                    if(_formKey.currentState!.validate()){
                                      await addPlumber().then((response) {
                                        if(response['status']==true){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                      "Plumber Registered Succesfully")));
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) {
                                              return LoginPage();
                                            },
                                          ));
                                        }
                                        else{
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      "Plumber Registration Failed")));
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) {
                                              return PlumberNotRegisteredPage();
                                            },
                                          ));
                                        }
                                      });
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
            // flagForStateDropDown ? Opacity(opacity: 0.5,
            // child: CustomLoader()):Container()
            Builder(builder: (context){
              return TextButton( onPressed: () => Scaffold.of(context).openDrawer(), child: CustomIcon());
            }),
          ],
        ),
        drawer: CustomDrawer(),
      ),
    );
  }
  Future<List<Map<String, String>>> getStates() async {
    const apiURL = "https://cqpplefitting.com/ad_cqpple/Api/State/ADMIN123123";
    var res = await http.get(Uri.parse(apiURL));
    List stateObjects = jsonDecode(res.body)["data"];
    List<Map<String, String>> stateList = [];
    for (int i = 0; i < stateObjects.length; i++) {
      Map<String, String> map = new Map<String, String>();
      map["id"] = stateObjects[i]["id"].toString();
      map["name"] = stateObjects[i]["name"].toString();
      stateList.add(map);
    }


    return stateList;
  }

  Future<List<Map<String, String>>> getCities() async {
    setState(() {});
    String apiURL = "https://cqpplefitting.com/ad_cqpple/Api/City/ADMIN123123/" +
        selectedStateID;
    var res = await http.get(Uri.parse(apiURL));
    List cityObjects = jsonDecode(res.body)["data"];
    List<Map<String, String>> cityList = [];
    for (int i = 0; i < cityObjects.length; i++) {
      Map<String, String> map = new Map<String, String>();
      map["id"] = cityObjects[i]["id"].toString();
      map["name"] = cityObjects[i]["name"].toString();
      cityList.add(map);
    }
    flagForCityDropDown = true;
    widget.isLoading = false;
    isGetCities=true;

    return cityList;
  }
  Future<dynamic> addPlumber() async{
    var apiURL = "https://cqpplefitting.com/ad_cqpple/Api/Plumber";
    Map<String,String> map={};
    map["apikey"] = widget.apiKey;
    map["Name"] = nameController.text.toString();
    map["ContactNumber"] = contactNumberController.text.toString();
    map["WhatsappNumber"] = whatsappNumberController.text.toString();
    map["Address"] = addressController.text.toString();
    map["Pincode"] = pincodeController.text.toString();
    map["StateID"] = selectedStateID;
    map["CityID"] = selectedCityID;
    var response = await http.post(Uri.parse(apiURL),body: jsonEncode(map));
    print(response.statusCode);
    print(response.body);
    return jsonDecode(response.body.toString());
  }
}
