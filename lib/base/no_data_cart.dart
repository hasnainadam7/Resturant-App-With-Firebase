// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';

import 'package:resturantapp/utils/dimmensions.dart';
import 'package:resturantapp/widgets/BigText.dart';

class NoDataImgCart extends StatelessWidget {
  final String text;
  final String ImgPath;
  final Color clr;

  const NoDataImgCart(
      {super.key,
      required this.text,
      this.ImgPath = "assets/images/empty_cart.png",  this.clr= const Color(0xFFDF5E00)});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            ImgPath,
            height:Dimension.noDataImgHeight,
            width:Dimension.noDataImgWidth,
          ),
        ),
        SizedBox(height: Dimension.Height30,),
        BigText(text: text,color: clr,)
      ],
    );
  }
}
