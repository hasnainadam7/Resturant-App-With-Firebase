// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

import '../utils/dimmensions.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color color;

  final TextOverflow textOverflow;
  final double size;

  const BigText(
      {super.key,
        this.size=0,
      required this.text,
      this.color =const Color(0xFF332d2b),
      this.textOverflow = TextOverflow.ellipsis,
   });

  @override
  Widget build(BuildContext context) {

    return Text(
      text,
      overflow: textOverflow,
      maxLines: 1,
      style: TextStyle(
        fontSize: size==0 ?Dimension.BigTexts:size,
        fontFamily: "Roboto",
        color: color,
        fontWeight: FontWeight.w800
      ),
    );
  }
}
