import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSubmitBotton extends StatefulWidget {
  double margin_top = 0;
  double margin_bottom = 0;
  String title = "";
  dynamic onTap;
  bool disabled = false;
  CustomSubmitBotton(
      {super.key,
      this.margin_top = 0,
      this.margin_bottom = 0,
      this.title = "",
      this.onTap,
      this.disabled = false});

  @override
  State<CustomSubmitBotton> createState() => _CustomSubmitBottonState();
}

class _CustomSubmitBottonState extends State<CustomSubmitBotton> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap ?? () => {},
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: MediaQuery.of(context).size.width - 66,
        margin: EdgeInsets.only(
            top: widget.margin_top,
            bottom: widget.margin_bottom,
            left: 10,
            right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.disabled
                ? const Color.fromRGBO(163, 163, 163, 1)
                : const Color.fromRGBO(0, 65, 194, 1)),
        child: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
