
// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../utils/dimmensions.dart';

class SocialMediaIcons extends StatelessWidget {
  final String imgUrl;

  const SocialMediaIcons({
    super.key, required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimension.Height15 * 3,
      width: Dimension.Height15 * 3,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius:
        BorderRadius.all(Radius.circular(Dimension.Height15 * 3)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imgUrl),
        ),
      ),
    );
  }
}