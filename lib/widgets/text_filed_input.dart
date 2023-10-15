import 'package:flutter/material.dart';
import 'package:woo/utils/colors.dart';

class TextFiledInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  const TextFiledInput({super.key, this.isPass = false, required this.hintText, required this.textInputType, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
      ),
      style: TextStyle(
          color: primaryColor,
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
