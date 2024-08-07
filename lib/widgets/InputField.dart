// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../utils/colors.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData icon;
  bool readOnly;
  int maxLines;
  final bool obscureText;
  final TextEditingController textEditingController;

   InputField({super.key,
    required this.labelText,
    required this.hintText,
    required this.icon,this.maxLines=1,this.readOnly=false,
     this.obscureText=false, required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        readOnly:readOnly,
        maxLines:maxLines,
        cursorColor: AppColors.mainColor,
controller: textEditingController,
        obscureText: obscureText,
        decoration: InputDecoration(
          focusColor: AppColors.mainColor,

          // fillColor:AppColors.mainColor,
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: AppColors.mainColor), // Change color here
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.mainColor,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      )

    );
  }
}
