
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPButtonRow extends StatefulWidget {
  const OTPButtonRow({Key? key}) : super(key: key);

  @override
  State<OTPButtonRow> createState() => _OTPButtonRowState();
}

class _OTPButtonRowState extends State<OTPButtonRow> {
  var otpFieldController1 = TextEditingController();
  var otpFieldController2 = TextEditingController();
  var otpFieldController3 = TextEditingController();
  var otpFieldController4 = TextEditingController();

  final focusOn2ndField = FocusNode();
  final focusOn3rdField = FocusNode();
  final focusOn4thField = FocusNode();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 240, 240, 1),
                  borderRadius:
                  BorderRadius.all(Radius.circular(10))),
              child: TextFormField(
                controller: otpFieldController1,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: Color.fromRGBO(29, 29, 29, 1)
                ),
                onChanged: (value) {
                  setState(() {
                    if (value.length == 1) {
                      FocusScope.of(context)
                          .requestFocus(focusOn2ndField);
                    }
                  });
                },
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 240, 240, 1),
                  borderRadius:
                  BorderRadius.all(Radius.circular(10))),
              child: TextFormField(
                controller: otpFieldController2,
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Color.fromRGBO(29, 29, 29, 1)
                ),
                focusNode: focusOn2ndField,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                ],
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    if (value.length == 1) {
                      FocusScope.of(context)
                          .requestFocus(focusOn3rdField);
                    }
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 240, 240, 1),
                  borderRadius:
                  BorderRadius.all(Radius.circular(10))),
              child: TextFormField(
                controller: otpFieldController3,
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Color.fromRGBO(29, 29, 29, 1)
                ),
                focusNode: focusOn3rdField,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                ],
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    if (value.length == 1) {
                      FocusScope.of(context)
                          .requestFocus(focusOn4thField);
                    }
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              // color: Colors.transparent,
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 240, 240, 1),
                  borderRadius:
                  BorderRadius.all(Radius.circular(10))),
              child: TextFormField(
                controller: otpFieldController4,
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Color.fromRGBO(29, 29, 29, 1)
                ),
                focusNode: focusOn4thField,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                ],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
