import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormFieldItem extends StatelessWidget {
  String hintText;
  String labelText;
  TextInputType keyBordType;
  TextFormFieldItem(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.keyBordType});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: AppColors.kGray),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.kGray, width: 1.0),
            borderRadius: BorderRadius.circular(3.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kGray, width: 1.0),
              borderRadius: BorderRadius.circular(3.0))),
      keyboardType: TextInputType.text,
    );
  }
}
