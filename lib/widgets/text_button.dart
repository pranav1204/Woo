import 'package:flutter/material.dart';
import '../utils/colors.dart';

class Text_Button extends StatelessWidget {
  final Function()? function;
  final String text;
  const Text_Button({
    Key? key,
    required this.text,
    required this.function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: TextButtonBackgroundColor,
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.centerLeft,
          width: 250,
          height: 35,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}