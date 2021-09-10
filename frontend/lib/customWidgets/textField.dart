import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefix,
    required this.whenEmpty,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final Icon prefix;
  final bool obscureText;
  final String whenEmpty;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          obscureText: obscureText,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return whenEmpty;
            }
            return null;
          },
          decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: hintText,
              labelStyle: TextStyle(fontFamily: 'Merienda',),
              prefixIcon: prefix,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusColor: Colors.teal),
        ),
      ),
    );
  }
}
