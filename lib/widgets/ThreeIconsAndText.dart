// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp/utils/dimmensions.dart';
import 'package:resturantapp/widgets/SmallText.dart';



class ThreeIconAndText extends StatelessWidget {

  final String IconOneText;
  final IconData IconOne;
  final Color IconOnecolor;
  final String IconTwoText;
  final IconData IconTwo;
  final Color IconTwocolor;
  final String IconThreeText;
  final IconData IconThree;
  final Color IconThreecolor;
  const ThreeIconAndText(
      {super.key,
      this.IconOneText = "Normal",
      this.IconOne = CupertinoIcons.circle_fill,
      this.IconOnecolor = const Color(0xFFffd379),
      this.IconTwoText = "1.7km",
      this.IconTwo = CupertinoIcons.location_solid,
      this.IconTwocolor = const Color(0xFF89dad0),
      this.IconThreeText = "30mins",
      this.IconThree = CupertinoIcons.time,
      this.IconThreecolor = Colors.red});

  @override
  Widget build(BuildContext context) {


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Wrap(
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              size: Dimension.IconSize,
              IconOne,
              color: IconOnecolor,
            ),
            SmallText(text: IconOneText),
          ],
        ),


Wrap(
  runAlignment: WrapAlignment.center,
  crossAxisAlignment: WrapCrossAlignment.center,
  children: [  Icon(
    size: Dimension.IconSize,
    IconTwo,
    color: IconTwocolor,
  ),SizedBox(
      width:Dimension.MobileWidth/5.23,
      child: SmallText(text: IconTwoText)),],
),

Wrap(
  runAlignment: WrapAlignment.center,
  crossAxisAlignment: WrapCrossAlignment.center,
  children: [
    Icon(
      size: Dimension.IconSize,
      IconThree,
      color: IconThreecolor,
    ),
    // SizedBox(width: Dimmensions.Width5,),
    SmallText(text: IconThreeText),
  ],
)

      ],
    );
  }
}
