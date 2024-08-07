// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class Paymentinputfield extends StatelessWidget {

  final TextInputType type;

  final bool obscureText;
  final TextEditingController textEditingController;

  const Paymentinputfield({
    super.key,

    this.obscureText = false,
    required this.textEditingController,
    required this.type,
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
          keyboardType: type,
          cursorColor: AppColors.mainColor,
          controller: textEditingController,
          obscureText: obscureText,
          decoration: InputDecoration(
            focusColor: AppColors.mainColor,

            floatingLabelBehavior: FloatingLabelBehavior.never,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                  color: AppColors.mainColor), // Change color here
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ));
  }
}
