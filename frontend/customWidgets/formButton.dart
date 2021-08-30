import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  FormButton({
    Key? key,
    required this.color,
    required this.buttonLabel,
    required this.onpressed,
  }) : super(key: key);
  final Color color;
  final String buttonLabel;
  final Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          minimumSize: Size(MediaQuery.of(context).size.width-100,50),
          primary: color),
        child: Text(buttonLabel),
        onPressed: onpressed,
      ),
    );
  }
}
