// ignore_for_file: file_names, non_constant_identifier_names

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturantapp/Routes/routesHelper.dart';
import 'package:resturantapp/controller/cart_repo_controller.dart';
import 'package:resturantapp/controller/product_repo_controller.dart';
import 'package:resturantapp/widgets/AppIcons.dart';
import 'package:resturantapp/widgets/BigText.dart';

import '../../models/product_models.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/dimmensions.dart';
import '../../widgets/AppColumn.dart';
import '../../widgets/ShoppingCartIcon.dart';

class PopularFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetails({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {

    var product =
        Get.find<ProductRepoController>().getPopularProductList[pageId];
    Get.find<ProductRepoController>()
        .initProducts(product, Get.find<CartRepoController>());

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.grayColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimension.Width30),
              topLeft: Radius.circular(Dimension.Width30)),
        ),
        margin: EdgeInsets.symmetric(horizontal: Dimension.Width10),
        padding: EdgeInsets.symmetric(vertical: Dimension.Height10),
        child: GetBuilder<ProductRepoController>(builder: (context) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: Dimension.Height30 * 1.5,
                width: Dimension.Width30 * 6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(Dimension.Width5 * 7)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: Dimension.Height30,
                      width: Dimension.Height30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimension.Width5 * 2)),
                      child: GestureDetector(
                        onTap: () {
                          context.setQunatity(true);
                        },
                        child: const Icon(
                          Icons.add,
                          size: 25,
                          color: AppColors.mainBlackColor,
                        ),
                      ),
                    ),
                    BigText(
                        size: Dimension.Height30 / 1.5,
                        text: Get.find<ProductRepoController>()
                            .getQuantity
                            .toString(),
                        color: Colors.black),
                    Container(
                        height: Dimension.Height30,
                        width: Dimension.Height30,
                        decoration: BoxDecoration(
                            // color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimension.Width5 * 2)),
                        child: GestureDetector(
                          onTap: () {
                            context.setQunatity(false);
                          },
                          child: const Icon(
                              size: 25,
                              color: AppColors.mainBlackColor,
                              CupertinoIcons.minus),
                        )),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {

                  context.addItems(product);
                  // Get.find<CartRepoController>().addItems(product,productController.getQuantity);
                },
                child: Container(
                    height: Dimension.Height30 * 1.5,
                    width: Dimension.Width30 * 10,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimension.Width5 * 7)),
                    child: Center(
                        child: BigText(
                      text:
                          "\$${product.price * Get.find<ProductRepoController>().getCartItems}.00 | Add to cart",
                      color: Colors.white,
                      size: Dimension.Width15 * 2.3,
                    ))),
              )
            ],
          );
        }),
      ),
      body: _PopularStack(product),
    );
  }

  Stack _PopularStack(ProductsModel product) {
    final String imageUrl = product.img??"";
    String name = product.name ?? 'Example';
    int stars = product.stars ?? 0;
    String description =
        product.description ?? "Invalid description, 404 error not found";
    String location = product.location ?? 'Canada, British Columbia';
    int price = product.price ?? 120;

    return Stack(
      children: [
        // Image
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,
            height: Dimension.PopularImageContainer,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imageUrl),
              ),
            ),
          ),
        ),
        // Left Right Icons
        Positioned(
          top: Dimension.Height15 * 3,
          left: Dimension.Width30,
          right: Dimension.Width30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {

                    if (page == "cart") {
                      Get.toNamed(Routeshelper.getFoodHomePageRoute(1));
                    } else {
                      Get.toNamed(Routeshelper.getFoodHomePageRoute(0));
                    }
                  },
                  child: const Appicons(icon: CupertinoIcons.back)),
              const shoppingCartIcon(),
            ],
          ),
        ),
        // Description
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: Dimension.PopularImageContainer / 1.05,
          child: Container(
            padding: EdgeInsets.only(
              left: Dimension.Width30,
              right: Dimension.Width30,
              top: Dimension.Height10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimension.Width30),
                topRight: Radius.circular(Dimension.Width30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppColumn(
                  Size: Dimension.Width30 * 2,
                  Name: name,
                  Stars: stars,
                  Location: location,
                  Price: price,
                ),
                SizedBox(height: Dimension.Height10),
                // BigText(text: description),
                SizedBox(height: Dimension.Height10),
                Expanded(
                  child: SingleChildScrollView(
                    child: ExpandableText(
                      style: const TextStyle(color: AppColors.textColor),
                      description,
                      expandText: 'show mores',
                      collapseText: 'show less',
                      maxLines: 6,
                      linkColor: Colors.blue[200],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
