import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  String title1 = "", title2 = "";

  CustomAppBar({String title1 = "", String title2 = ""}) {
    this.title1 = title1;
    this.title2 = title2;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Color.fromRGBO(0, 65, 194, 1),
          height: 302,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(70)),
                color: Color.fromRGBO(24, 83, 201, 0.70)),
            margin:
            EdgeInsets.only(left: MediaQuery.of(context).size.width - 150),
            // Adjust the size of the circular container
            height: 100,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(120),
                    topLeft: Radius.circular(120),
                    bottomRight: Radius.circular(27)),
                color: Color.fromRGBO(21, 83, 215, 0.5)),
            margin:
            EdgeInsets.only(left: MediaQuery.of(context).size.width - 110),
            height: 140,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, left: 29),
              child: Text(
                title1,
                style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width>330? 31: 28,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 29),
              child: Text(
                title2,
                style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width>330? 31: 28,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
}
