import 'package:flutter/material.dart';
import 'package:resturantapp/utils/dimmensions.dart';

import '../utils/colors.dart';

class Customloadingbar extends StatelessWidget {
  const Customloadingbar({super.key});

  @override
  Widget build(BuildContext context) {
 return Center(
        child: Container(
          alignment: Alignment.center,
          height: Dimension.Height15*4, // Adjust the height as needed
          width: Dimension.Height15*4, // Adjust the width as needed
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(Dimension.Width30), // Adjust the border radius as needed
          ),
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.0, // Adjust the stroke width as needed
          ),
        ));
  }


}
