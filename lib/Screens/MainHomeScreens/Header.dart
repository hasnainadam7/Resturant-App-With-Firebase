
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimmensions.dart';
import '../../widgets/BigText.dart';
import '../../widgets/SmallText.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {

    return  Container(
    height: Dimension.Height10*8,
      padding: EdgeInsets.only(top: Dimension.Height10,bottom: Dimension.Height10),
      margin: EdgeInsets.only(left: Dimension.Width10,right: Dimension.Width10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const BigText(
                text: 'Pakistan',
                color: AppColors.mainColor,
              ),
              Row(
                children: [
                  SmallText(text: "Karachi",color: Colors.black54,),
                  const Icon(Icons.arrow_drop_down)
                ],
              )
            ],
          ),
          Container(
            height: Dimension.Height15*3,
            width: Dimension.Width15*6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimension.BorderRadius5*3),
              color: AppColors.mainColor,
            ),
            child: const Icon(color: Colors.white, CupertinoIcons.search),
          )
        ],
      ),
    );
  }
}
