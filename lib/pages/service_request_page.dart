import 'dart:convert';
import 'dart:io';
import 'package:bath_service_project/Utils/preference.dart';
import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/custom/custom_loader.dart';
import 'package:bath_service_project/custom/internet_checking.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:bath_service_project/pages/service_status_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../custom/custom_icon.dart';
import '../custom/custom_submit_button.dart';
import '../custom/customappbar.dart';

class ServiceRequestFormPage extends StatefulWidget {
  Map data = {};
  var apikey = "";
  String ServiceID = "0";

  bool isLoading = false;

  ServiceRequestFormPage({super.key, data}) {
    this.data = data;
  }

  VideoPlayerController videoController = VideoPlayerController.networkUrl(
      Uri.parse("https://www.youtube.com/watch?v=72x6N_fVN4A"));

  @override
  State<ServiceRequestFormPage> createState() => _ServiceRequestFormPageState();
}

class _ServiceRequestFormPageState extends State<ServiceRequestFormPage> {
  String problemID = "";
  bool flagForProblemDropDown = true;
  File? imageFile;
  File? videoFile;
  int imageSize = 0;
  int videoSize = 0;

  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const InternetChecking(),
            CustomAppBar(
              title1: "",
              title2: "Service Request",
            ),
            Container(
              margin: const EdgeInsets.only(top: 160),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white),
              height: MediaQuery.of(context).size.height - 188,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 33, right: 33, top: 40, bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Problem",
                        style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(29, 29, 29, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        color: Colors.transparent,
                        height: 57,
                        child: Card(
                          color: const Color.fromRGBO(246, 246, 246, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), //<-- SEE HERE
                          ),
                          child: FutureBuilder(
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (flagForProblemDropDown) {
                                  flagForProblemDropDown = false;
                                }
                                return Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: DropDownTextField(
                                    searchAutofocus: true,
                                    dropdownRadius: 5,
                                    listTextStyle: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                    textStyle: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                    textFieldDecoration: const InputDecoration(
                                        hintText: "Select Problem"),
                                    enableSearch: true,
                                    listPadding: ListPadding(top: 5),
                                    dropDownList:
                                        snapshot.data!.map((Map item) {
                                      return DropDownValueModel(
                                          name: item["Problem"],
                                          value: item["ProblemID"]);
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        print(newValue.value);
                                        problemID = newValue!.value.toString();
                                      });
                                    },
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      height: 20,
                                      width: 20,
                                      child: const CircularProgressIndicator()),
                                );
                              }
                            },
                            future:
                                flagForProblemDropDown ? getProblems() : null,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 14),
                        child: Text(
                          "Add Image",
                          style: GoogleFonts.poppins(
                              color: const Color.fromRGBO(29, 29, 29, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      if (imageFile == null)
                        getNetworkImage(
                            "https://cqpplefitting.com/ad_cqpple/Images/demo.jpg"),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: InkWell(
                          child: CustomSubmitBotton(
                            title: "Add",
                            onTap: () {
                              showPickerOption(
                                forImage: true,
                                context: context,
                              );
                            },
                          ),
                        ),
                      ),
                      imageFile == null
                          ? Container()
                          : imageSize >= 10000000
                              ? Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 20),
                                  child: Text(
                                    "Upload image upto 10 MB",
                                    style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Image.file(
                                      imageFile!,
                                      height: 240,
                                      width: 240,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                      Container(
                        margin: const EdgeInsets.only(top: 14),
                        child: Text(
                          "Add Video",
                          style: GoogleFonts.poppins(
                              color: const Color.fromRGBO(29, 29, 29, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: InkWell(
                          child: CustomSubmitBotton(
                            title: "Add",
                            onTap: () {
                              showPickerOption(
                                forImage: false,
                                context: context,
                              );
                            },
                          ),
                        ),
                      ),
                      videoFile == null
                          ? Container()
                          : videoSize >= 20000000
                              ? Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 20),
                                  child: Text(
                                    "Upload video upto 20 MB",
                                    style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          height: 240,
                                          width: 240,
                                          child: widget.videoController.value
                                                  .isInitialized
                                              ? VideoPlayer(
                                                  widget.videoController)
                                              : Container(),
                                        ),
                                        InkWell(
                                          child: CustomSubmitBotton(
                                            margin_top: 20,
                                            title: "Play",
                                            onTap: () {
                                              setState(() {
                                                widget.videoController.value
                                                        .isPlaying
                                                    ? widget.videoController
                                                        .pause()
                                                    : widget.videoController
                                                        .play();
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                      CustomSubmitBotton(
                        margin_top: 70,
                        title: "Submit",
                        onTap: () async {
                          if (problemID != "" &&
                              videoFile != null &&
                              imageFile != null &&
                              imageSize < 10000000 &&
                              videoSize < 20000000) {
                            await addRequest();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.green,
                                    content:
                                        Text("Service Added Succesfully")));
                            if (PreferencesManager.getRole() ==
                                UserRole.dealer) {
                              Navigator.of(context).popUntil((route) {
                                return route.isFirst;
                              });
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ServiceStatusPage(
                                        ServiceID: widget.ServiceID);
                                  },
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Invalid Problem Or Image Or Video.")));
                          }
                        },
                      )
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
        drawer: CustomDrawer(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget getNetworkImage(String urlString) {
    return Image.network(
      urlString,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }

  void showPickerOption(
      {required bool forImage, required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              if (forImage) {
                getImage(ImageSource.gallery);
              } else {
                getVideo(ImageSource.gallery);
              }
            },
          ),
          /* ListTile(
            title: const Text('File'),
            onTap: () async {},
          ),*/
          ListTile(
            title: const Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              if (forImage) {
                getImage(ImageSource.camera);
              } else {
                getVideo(ImageSource.camera);
              }
            },
          ),
        ],
      ),
    );
  }

  void getImage(ImageSource source) {
    imagePicker.pickImage(source: source).then((image) {
      if (image != null) {
        setState(() {
          imageFile = File(image.path);
        });
        image.length().then((length) {
          imageSize = length;
        });
      }
    });
  }

  void getVideo(ImageSource source) {
    imagePicker.pickVideo(source: source).then(
      (video) {
        if (video != null) {
          videoFile = File(video.path);
          widget.videoController = VideoPlayerController.file(videoFile!)
            ..initialize().then(
              (value) {
                setState(() {});
              },
            );
          video.length().then((value) {
            videoSize = value;
          });
        }
      },
    );
  }

  /* void getImageFromGallery() async {
    var img = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(img!.path);
      img.length().then((value) {
        setState(() {
          imageSize = value;
        });
      });
    });
  }

  void getVideoFromGallery() async {
    var video = await imagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      videoFile = File(video!.path);
      widget.videoController = VideoPlayerController.file(videoFile!)
        ..initialize().then(
          (value) {
            setState(() {});
          },
        );
      video.length().then((value) {
        videoSize = value;
      });
    });
  }*/

  Future<List<Map<String, String>>> getProblems() async {
    widget.apikey = PreferencesManager.getAPIKey();
    String apiURL =
        "https://cqpplefitting.com/ad_cqpple/Api/Problem/${widget.apikey}";
    var res = await http.get(Uri.parse(apiURL));
    List problemObjects = jsonDecode(res.body)["data"];
    List<Map<String, String>> problemList = [];
    for (int i = 0; i < problemObjects.length; i++) {
      Map<String, String> map = <String, String>{};
      map["ProblemID"] = problemObjects[i]["ProblemID"].toString();
      map["Problem"] = problemObjects[i]["Problem"].toString();
      problemList.add(map);
    }
    return problemList;
  }

  Future<void> addRequest() async {
    setState(() {
      widget.isLoading = true;
    });

    widget.apikey = PreferencesManager.getAPIKey();

    var apiURL = "https://cqpplefitting.com/ad_cqpple/Api/RequestForService";
    var request = http.MultipartRequest('POST', Uri.parse(apiURL));
    print(widget.data["Address"]);
    request.fields["apikey"] = widget.apikey;
    request.fields["ProblemID"] = problemID;
    request.fields["Name"] = widget.data["Name"];
    request.fields["ContactNumber"] = widget.data["ContactNumber"];
    request.fields["WhatsappNumber"] = widget.data["WhatsappNumber"];
    request.fields["Address"] = widget.data["Address"];
    request.fields["Pincode"] = widget.data["Pincode"];
    request.fields["StateID"] = widget.data["StateID"];
    request.fields["CityID"] = widget.data["CityID"];
    var multipartImage =
        await http.MultipartFile.fromPath('BeforeImagePath1', imageFile!.path)
            .then((value) {
      request.files.add(value);
    });
    var multipartVideo =
        await http.MultipartFile.fromPath('BeforeVideopath2', videoFile!.path)
            .then((value) {
      request.files.add(value);
    });
    print(request.files);
    var response = await http.Response.fromStream(await request.send());
    var responseData = await jsonDecode(response.body);
    print(responseData);
    widget.isLoading = false;
    widget.ServiceID = responseData["data"][0]["ServiceID"];
    print(widget.ServiceID);
  }
}
