import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String text;
  const Label({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        color: Colors.amber,
        fontFamily: "opensans",
      ),
    );
  }
}
