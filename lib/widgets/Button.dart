// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimmensions.dart';

class Button extends StatelessWidget {
  final VoidCallback callBack;
  final String Label;

  const Button({super.key, required this.callBack, required this.Label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callBack,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.mainColor, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimension.Height15 *
              2), // Circular shape with a specific radius
        ),
        elevation: 5, // Elevation shadow
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimension.Width15 * 1.3,
            horizontal: Dimension.Height30 ), // Padding around the text
        child: Text(
          Label,
          style: TextStyle(fontSize: Dimension.Width3 * 15),
        ),
      ),
    );
  }
}
