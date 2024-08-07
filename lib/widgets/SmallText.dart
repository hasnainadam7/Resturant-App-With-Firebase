// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/cupertino.dart';


import '../utils/dimmensions.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  double? size;
  FontWeight? fontweight;

  SmallText({
    super.key,
    required this.text,
    this.color = const Color(0xFFccc7c5),
    this.height = 1.2,
    this.size,
    this.fontweight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: size ?? Dimension.SmallTexts,
          height: height,
          fontFamily: "Roboto",
          color: color,
          fontWeight: fontweight ?? FontWeight.w300),
    );
  }
}
