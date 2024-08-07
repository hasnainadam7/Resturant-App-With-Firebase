// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimmensions.dart';
import 'BigText.dart';
import 'SmallText.dart';
import 'ThreeIconsAndText.dart';

class AppColumn extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final double Size;
  final String Name ;
  final int Stars;
  final String Location;
  final int Price;
  const AppColumn(
      {super.key,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.Size=0,
     required this.Name, required this.Stars, required this.Location, required this.Price});

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      height: Dimension.AppColumnHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          BigText(
            text: Name,
            size: Size==0 ? Dimension.Width30*1.2: Size,
          ),
          Row(
            children: [
              Wrap(
                children: List.generate(5, (i) {
                  return Icon(
                    i < Stars ? Icons.star : Icons.star_border,
                    color: AppColors.mainColor,
                    size: 15,
                  );
                }
              ),),
              SizedBox(width: Dimension.Width10),
              SmallText(text: Stars.toString()),
              SizedBox(width: Dimension.Height10),
              SmallText(text: "1232"),
              SizedBox(width: Dimension.Height10/5),
              SmallText(text: "reviews"),
            ],
          ),
          SizedBox(height: Dimension.Height10 * 2),
          ThreeIconAndText(IconOneText: Price.toString(),IconTwoText: Location),
        ],
      ),
    );
  }
}
