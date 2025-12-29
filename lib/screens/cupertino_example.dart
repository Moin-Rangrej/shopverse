import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoExample extends StatefulWidget {
  const CupertinoExample({super.key});

  @override
  State<CupertinoExample> createState() => _CupertinoExampleState();
}

class _CupertinoExampleState extends State<CupertinoExample> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: "Cupertino Example",
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.activeOrange,
        barBackgroundColor: Colors.amber
      ),
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.activeBlue,
          middle: Text("Flutter demo Layout"),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Hello World")],
          ),
        ),
      ),
    );
  }
}
