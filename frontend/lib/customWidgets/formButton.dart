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
      height: 30,
      decoration: BoxDecoration(color: color),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      width: MediaQuery.of(context).size.width / 1.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: color),
        child: Text(buttonLabel),
        onPressed: onpressed,
      ),
    );
  }
}
