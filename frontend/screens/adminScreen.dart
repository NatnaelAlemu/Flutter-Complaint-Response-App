import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  static const String routeName = "/adminScreen";
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Admin Screen")),
        body: Center(
          child: Text("Admin Screen"),
        ));
  }
}
