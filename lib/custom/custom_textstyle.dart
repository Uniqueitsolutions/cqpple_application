import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle extends StatelessWidget {
  String title = "";

  CustomTextStyle({String title = ""}) {
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Text(title,
      style: GoogleFonts.poppins(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 17,
        fontWeight: FontWeight.w500
      ),
    );
  }
}


