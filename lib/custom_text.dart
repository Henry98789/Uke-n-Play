import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  // changes made in this class apply to all instances of CustomText
  const CustomText(
      {super.key,
      required this.myText,
      required this.containerColor,
      required this.textColor});

  final String myText;
  final Color containerColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueAccent,
        child: Text(myText,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            )));
  }
}
