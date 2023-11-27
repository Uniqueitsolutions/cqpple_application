import 'dart:convert';

import 'package:bath_service_project/custom/custom_drawer.dart';
import 'package:bath_service_project/custom/custom_loader.dart';
import 'package:bath_service_project/custom/custom_textstyle.dart';
import 'package:bath_service_project/pages/login_page.dart';
import 'package:bath_service_project/pages/plumber_service_token_page.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'dart:io';
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
import 'package:http/http.dart' as http;

class PlumberServiceDetailsPage extends StatefulWidget {
  final String complainNumber;
  String apikey = "";
  bool isLoading = false;
  PlumberServiceDetailsPage({super.key, required this.complainNumber});

  VideoPlayerController videoController = VideoPlayerController.networkUrl(
      Uri.parse("https://www.youtube.com/watch?v=72x6N_fVN4A"));

  @override
  State<PlumberServiceDetailsPage> createState() =>
      _PlumberServiceDetailsPageState();
}

class _PlumberServiceDetailsPageState extends State<PlumberServiceDetailsPage> {
  int imageSize = 0;
  int videoSize = 0;
  File? imageFile;
  File? videoFile;

  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomAppBar(
              title1: "",
              title2: "Plumber Service",
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 160),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height - 188,
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data.toString() != "Completed") {
                        return SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 33, right: 33, top: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomTextStyle(
                                  title: "Service Details",
                                ),
                                Center(
                                  child: Container(
                                    height: 120,
                                    margin: const EdgeInsets.only(top: 23),
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
                                              top: 10, left: 30),
                                          child: Text(
                                            snapshot.data!["Name"].toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 26,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.normal,
                                                color: const Color.fromRGBO(
                                                    29, 29, 29, 1)),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 8, left: 30),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  child: Text(
                                                    "Address :",
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
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5),
                                                  child: Text(
                                                    snapshot.data!["Address"],
                                                    textAlign: TextAlign.start,
                                                    style: GoogleFonts.poppins(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color
                                                            .fromRGBO(
                                                            131, 131, 131, 1)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 8, left: 30),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  child: Text(
                                                    "Mobile Number :",
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
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5),
                                                  child: Text(
                                                    snapshot
                                                        .data!["ContactNumber"],
                                                    textAlign: TextAlign.start,
                                                    style: GoogleFonts.poppins(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color
                                                            .fromRGBO(
                                                            131, 131, 131, 1)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  child: Text(
                                    "Add Image",
                                    style: GoogleFonts.poppins(
                                        color:
                                            const Color.fromRGBO(29, 29, 29, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: InkWell(
                                    child: CustomSubmitBotton(
                                      title: "Add",
                                      onTap: () async {
                                        final deviceInfo =
                                            await DeviceInfoPlugin()
                                                .androidInfo;
                                        if (deviceInfo.version.sdkInt > 32) {
                                          PermissionStatus photoPermission =
                                              await Permission.photos.request();
                                          if (photoPermission.isGranted) {
                                            getImageFromGallery();
                                          } else if (photoPermission.isDenied) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Storage Permission Denied.")));
                                          } else if (photoPermission
                                              .isPermanentlyDenied) {
                                            openAppSettings();
                                          }
                                        } else {
                                          PermissionStatus storagePermission =
                                              await Permission.storage
                                                  .request();
                                          if (storagePermission.isGranted) {
                                            getImageFromGallery();
                                          } else if (storagePermission
                                              .isDenied) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Storage Permission Denied.")));
                                          } else if (storagePermission
                                              .isPermanentlyDenied) {
                                            openAppSettings();
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                imageFile == null
                                    ? Container()
                                    : imageSize >= 10000000
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 20),
                                            child: Text(
                                              "Upload image upto 10 MB",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        : Center(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
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
                                        color:
                                            const Color.fromRGBO(29, 29, 29, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: InkWell(
                                    child: CustomSubmitBotton(
                                      title: "Add",
                                      onTap: () async {
                                        final deviceInfo =
                                            await DeviceInfoPlugin()
                                                .androidInfo;
                                        if (deviceInfo.version.sdkInt > 32) {
                                          PermissionStatus videoPermission =
                                              await Permission.videos.request();
                                          if (videoPermission.isGranted) {
                                            getVideoFromGallery();
                                          } else if (videoPermission.isDenied) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Storage Permission Denied.")));
                                          } else if (videoPermission
                                              .isPermanentlyDenied) {
                                            openAppSettings();
                                          }
                                        } else {
                                          PermissionStatus storagePermission =
                                              await Permission.storage
                                                  .request();
                                          if (storagePermission.isGranted) {
                                            getVideoFromGallery();
                                          } else if (storagePermission
                                              .isDenied) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Storage Permission Denied.")));
                                          } else if (storagePermission
                                              .isPermanentlyDenied) {
                                            openAppSettings();
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                videoFile == null
                                    ? Container()
                                    : videoSize >= 15000000
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 20),
                                            child: Text(
                                              "Upload video upto 15 MB",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        : Center(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    height: 240,
                                                    width: 240,
                                                    child: widget
                                                            .videoController
                                                            .value
                                                            .isInitialized
                                                        ? VideoPlayer(widget
                                                            .videoController)
                                                        : Container(),
                                                  ),
                                                  InkWell(
                                                    child: CustomSubmitBotton(
                                                      margin_top: 20,
                                                      title: "Play",
                                                      onTap: () {
                                                        setState(() {
                                                          widget.videoController
                                                                  .value.isPlaying
                                                              ? widget
                                                                  .videoController
                                                                  .pause()
                                                              : widget
                                                                  .videoController
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
                                    if (videoFile != null &&
                                        imageFile != null &&
                                        imageSize < 10000000 &&
                                        videoSize < 15000000) {
                                      await completeRequestByPlumber();

                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          widget.isLoading = false;
                                          return PlumberServiceTokenPage();
                                        },
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Invalid Image Or Video.")));
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError ||
                          snapshot.data.toString() == "Completed") {
                        return Container(
                          margin: const EdgeInsets.only(top: 40, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.dangerous_outlined,
                                      size: 30,
                                      color: Color.fromRGBO(227, 59, 36, 1)),
                                  Text(
                                    "Service Not Found",
                                    style: GoogleFonts.poppins(
                                        color: const Color.fromRGBO(
                                            227, 59, 36, 1),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              CustomSubmitBotton(
                                title: "Exit",
                                margin_top: 50,
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return CustomLoader();
                      }
                    },
                    future: getStatusByComplainNumber(),
                  ),
                ),
              ],
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
        drawer: const CustomDrawer(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  void getImageFromGallery() async {
    var img = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(img!.path);
    });
    img!.length().then((value) {
      setState(() {
        imageSize = value;
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
  }

  Future<Map> getStatusByComplainNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.apikey = prefs.getString("apikey")!;
    var apiURL =
        "https://cqpplefitting.com/ad_cqpple/Api/ServiceByComplainNumber";
    Map map = {};
    map["apikey"] = widget.apikey;
    map["ComplainNumber"] = widget.complainNumber;
    var response = await http.post(Uri.parse(apiURL), body: jsonEncode(map));
    print(response.statusCode);
    print(jsonDecode(response.body.toString()));

    return jsonDecode(response.body.toString())["data"][0];
  }

  Future<void> completeRequestByPlumber() async {
    setState(() {
      widget.isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.apikey = prefs.getString("apikey")!;
    var apiURL = "https://cqpplefitting.com/ad_cqpple/Api/CompeletedByPlumber";
    var request = http.MultipartRequest('POST', Uri.parse(apiURL));
    request.fields["apikey"] = widget.apikey;
    request.fields["ComplainNumber"] = widget.complainNumber;
    var multipartImage =
        await http.MultipartFile.fromPath('AfterImagePath1', imageFile!.path)
            .then((value) {
      request.files.add(value);
    });
    var multipartVideo =
        await http.MultipartFile.fromPath('AfterVideoPath2', videoFile!.path)
            .then((value) {
      request.files.add(value);
    });
    var response = await http.Response.fromStream(await request.send());
    var responseData = jsonDecode(response.body);
    print(responseData);
  }
}
