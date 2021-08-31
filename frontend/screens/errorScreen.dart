import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  static const String routeName = "/error";
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error "),
      ),
      body: Center(
        child: Text(
          "Something went wrong",
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      ),
    );
  }
}
