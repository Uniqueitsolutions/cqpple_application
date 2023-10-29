import 'package:bath_service_project/custom/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 83, 201, 0.70),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 83, 201, 0.70),
        title: Text("Contact us",style: GoogleFonts.poppins(fontWeight: FontWeight.w400),),
        leading: BackButton(
        onPressed: () {
            Navigator.of(context).pop();
            },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 30),
              child: Image.asset("assets/icons/AppLogo.png",height: 100,width: 100)),
          Container(
            margin: const EdgeInsets.only(top: 50,left: 20),
            child: Text("Do you have any issue or suggestion?",
              style: GoogleFonts.poppins(
                color: Color.fromRGBO(240, 240, 240, 1),
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            )
          ),
          Container(
            margin: const EdgeInsets.only(top: 50,left: 20),
            child: Text("Contact  :  Apple Fitting",
              style: GoogleFonts.poppins(
                  color: Color.fromRGBO(240, 240, 240, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.w400
              ),
            )
          ),
          GestureDetector(
            onTap: (){
              launch('tel:9913845600');
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20,top: 10),
              child: Row(
                children: [
                  Flexible(child: Image.asset("assets/icons/Call.png",height: 20,width: 20,)),
                  const SizedBox(width: 8),
                  Flexible(
                    flex: 3,
                    child: Text("+91 9913845600",
                      style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30,left: 20),
            child: Text("Mail : ",
              style: GoogleFonts.poppins(
                  color: Color.fromRGBO(240, 240, 240, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w400
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              launch('mailto:info@cqpplefitting.com?subject=issue or suggestion regarding aptitude &body=your issue or suggestion here');
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20,top: 10),
              child: Row(
                children: [
                  Flexible(
                      child: Image.asset("assets/icons/Mail.png",height: 20,width: 20,)
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    flex: 3,
                    child: Text("info@cqpplefitting.com",
                      style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent,
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
