import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSubmitBotton extends StatefulWidget {
  double margin_top = 0;
  String title = "";
  dynamic? onTap;
  bool disabled=false;
  CustomSubmitBotton(
      {double margin_top = 0, String title = "", dynamic onTap,bool disabled=false}) {
    this.margin_top = margin_top;
    this.title = title;
    this.onTap = onTap;
    this.disabled=disabled;
  }

  @override
  State<CustomSubmitBotton> createState() => _CustomSubmitBottonState();
}

class _CustomSubmitBottonState extends State<CustomSubmitBotton> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap == null ? () => {} : widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: MediaQuery.of(context).size.width - 66,
        margin: EdgeInsets.only(top: widget.margin_top, left: 10, right: 10),
        child: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.disabled ? Color.fromRGBO(163, 163, 163, 1) :Color.fromRGBO(0, 65, 194, 1)),
      ),
    );
  }
}
