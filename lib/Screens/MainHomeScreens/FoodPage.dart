// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:resturantapp/utils/dimmensions.dart';
import 'package:resturantapp/widgets/BigText.dart';
import 'package:resturantapp/widgets/SmallText.dart';

import 'SliderFoodPage.dart';
import 'Header.dart';
import 'ListViewFoodPage.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimension.Height10,
                    ),
                    //Slider and DotIndicator
                    const SliderRecommendedFood(),
                    SizedBox(
                      height: Dimension.Height10,
                    ),
                    // Popular Text
                    Container(
                      margin: EdgeInsets.only(
                          left: Dimension.Width30,
                          right: Dimension.Width30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const BigText(text: "Popular"),
                          SizedBox(
                            width: Dimension.Width15,
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: const BigText(text: ".", color: Colors.black26),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(bottom: Dimension.Width10),
                            child: SmallText(text: "  Food Pairing "),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimension.Height10,
                    ),
                    // List of Items
                    const ListViewContainer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
