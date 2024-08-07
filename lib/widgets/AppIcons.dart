// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:resturantapp/utils/dimmensions.dart';

class Appicons extends StatelessWidget {
  final IconData icon;
  final Color colr;
  final double size;
  final Color backclor;
  final double IconSize;
  const Appicons(
      {super.key,
      required this.icon,
      this.colr = const Color(0xFF756d54),
      this.size = 40,
      this.IconSize = 40,
      this.backclor = const Color(0xFFfcf4e4)});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: IconSize == 40 ? Dimension.Width30*2 : IconSize,
      width:IconSize == 40 ? Dimension.Width30*2 : IconSize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IconSize / 2), color: backclor),
      child: Icon(

        icon,
        color: colr,
        size: size == 40 ? Dimension.Width30 : size,
      ),
    );
  }
}
