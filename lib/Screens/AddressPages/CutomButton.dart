import 'package:flutter/material.dart';
import 'package:resturantapp/utils/dimmensions.dart';

import '../../utils/colors.dart';

class Cutombutton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? btnText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height, width, radius, fontSize;
  final IconData icon;

  const Cutombutton(
      {super.key,
      this.onPressed,
      this.btnText,
      this.transparent = false,
      this.margin,
      this.height,
      this.width,
      this.radius = 5,
      this.fontSize,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatBtn = TextButton.styleFrom(
        backgroundColor: onPressed == null
            ? Theme.of(context).disabledColor
            : (transparent
                ? Colors.transparent
                : AppColors.mainColor),
        minimumSize: Size(width == null ? Dimension.MobileWidth : width!,
            height == null ? Dimension.Height15 * 3 : height!),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!)));
    return Center(
      child: SizedBox(
        width: width ?? Dimension.MobileWidth,
        height: height ?? Dimension.Height30 * 2,
        child: TextButton(
          onPressed: onPressed,
          style: flatBtn,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                        padding: EdgeInsets.only(right: Dimension.Width5),
                        child: Icon(
                          icon,
                          color: transparent
                              ? AppColors.mainColor
                              : Theme.of(context).cardColor,
                        ),
                      )
                    ,
                Text(
                  btnText!,
                  style: TextStyle(
                    fontSize: fontSize ?? Dimension.Height15,
                    color: !transparent
                        ? Colors.white
                        : Theme.of(context).cardColor,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
