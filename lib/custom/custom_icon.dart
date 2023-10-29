import 'package:flutter/material.dart';

class CustomIcon extends StatefulWidget {
  const CustomIcon({super.key});

  @override
  State<CustomIcon> createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.menu,color: Colors.white,size: 30,);
  }
}
