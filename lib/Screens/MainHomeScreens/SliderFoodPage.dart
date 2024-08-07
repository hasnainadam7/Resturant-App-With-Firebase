// ignore_for_file: file_names, non_constant_identifier_names, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturantapp/controller/product_repo_controller.dart';
import 'package:resturantapp/utils/colors.dart';
import 'package:resturantapp/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Routes/routesHelper.dart';
import '../../models/product_models.dart';
import '../../utils/dimmensions.dart';
import '../../widgets/AppColumn.dart';
import '../../widgets/CustomLoadingBar.dart';

class SliderRecommendedFood extends StatefulWidget {
  const SliderRecommendedFood({super.key});

  @override
  State<SliderRecommendedFood> createState() => _SliderRecommendedFoodState();
}

class _SliderRecommendedFoodState extends State<SliderRecommendedFood> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double _currPage = 0.0;
  final double _scaleFactor = 0.75;
  int count = 0;
  final _height = Dimension.homeImageContainerHeight;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductRepoController>(builder: (context) {
      var products = context.getrecommendedProductList;
      count=products.length > 0 ? products.length : 0;
      return context.isloaded
          ? Column(
              children: [
                SizedBox(
                  height: Dimension.HomeSliderContainerHeight,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: count,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routeshelper.getRecommendedFoodRoute(
                                position, "home"));
                          },
                          child: _buildPageItem(position, products[position]));
                    },
                  ),
                ),
                AnimatedSmoothIndicator(
                  activeIndex: _currPage.round(),
                  count:products.length,
                  effect:  ExpandingDotsEffect(
                    activeDotColor: AppColors.mainColor,
                    dotWidth: Dimension.Width3*5,
                    dotHeight: Dimension.Width3*5,
                  ),
                  onDotClicked: (index) {
      print('Dot $index clicked');},
                )
              ],
            )
          : const Customloadingbar();
    });
  }

  Widget _buildPageItem(int index, ProductsModel product) {
    Matrix4 matrix = Matrix4.identity();
    double currScale = 1.0;
    double currTrans = 0.0;

    if (index == _currPage.floor()) {
      currScale = 1 - (_currPage - index) * (1 - _scaleFactor);
      currTrans = _height * (1 - currScale) / 2;
    } else if (index == _currPage.floor() + 1) {
      currScale = _scaleFactor + (_currPage - index + 1) * (1 - _scaleFactor);
      currTrans = _height * (1 - currScale) / 2;
    } else {
      currScale = _scaleFactor;
      currTrans = _height * (1 - currScale) / 2;
    }
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);

    // Ensure that the product image is not null
    String imageUrl = product.img ?? 'https://example.com/default_image.png';
    String Name = product.name ?? 'Example';
    int Stars = product.stars ?? 3;
    String Location = product.location ?? 'Canada, British Columbia';
    int Price = product.price ?? 120;
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimension.Width10, right: Dimension.Width10),
            margin: EdgeInsets.only(
                left: Dimension.Width10, right: Dimension.Width10),
            height: Dimension.homeImageContainerHeight,
            decoration: BoxDecoration(
              color:
                  index / 2 == 0 ? AppColors.blueColor : AppColors.purpleColor,
              borderRadius:
                  BorderRadius.circular(Dimension.BorderRadius5 * 6),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("${Constants.BASE_URL}uploads/$imageUrl"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimension.homeTextContainerHeight,
              width: Dimension.homeTextContainerWidth,
              margin: EdgeInsets.only(
                  bottom: Dimension.Height10,
                  left: Dimension.Width30,
                  right: Dimension.Width30),
              padding: EdgeInsets.only(
                  left: Dimension.Width15, right: Dimension.Width15),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 3.0,
                      offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0))
                ],
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(Dimension.BorderRadius5 * 6),
              ),
              child: AppColumn(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                Name: Name,
                Stars: Stars,
                Location: Location,
                Price: Price,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
