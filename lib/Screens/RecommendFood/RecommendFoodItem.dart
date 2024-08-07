// ignore_for_file: non_constant_identifier_names, file_names

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturantapp/controller/cart_repo_controller.dart';
import 'package:resturantapp/controller/product_repo_controller.dart';
import 'package:resturantapp/models/product_models.dart';
import 'package:resturantapp/utils/colors.dart';
import 'package:resturantapp/utils/dimmensions.dart';
import 'package:resturantapp/widgets/AppIcons.dart';
import 'package:resturantapp/widgets/BigText.dart';

import '../../Routes/routesHelper.dart';
import '../../utils/constants.dart';
import '../../widgets/ShoppingCartIcon.dart';

class RecommendFood extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendFood({super.key, required this.pageId,  required this.page});

  @override
  Widget build(BuildContext context) {

    var product = Get.find<ProductRepoController>().getrecommendedProductList[pageId];
    Get.find<ProductRepoController>().initProducts(product, Get.find<CartRepoController>());
    Get.find<ProductRepoController>()
        .initProducts(product, Get.find<CartRepoController>());
    var price = product.price;

    return Scaffold(
      bottomNavigationBar: GetBuilder<CartRepoController>(
        builder: (cartController) {
          return GetBuilder<ProductRepoController>(
            builder: (productController) {
              return Container(
                padding: EdgeInsets.only(top: Dimension.Height10),
                margin: EdgeInsets.symmetric(horizontal: Dimension.Width10 * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimension.Height10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              productController.setQunatity(true);
                            },
                            child: Appicons(
                              icon: Icons.add,
                              colr: Colors.white,
                              size: Dimension.Width30,
                              IconSize: Dimension.Height10 * 5,
                              backclor: AppColors.mainColor,
                            ),
                          ),
                          BigText(
                            text: "\$$price.00 X ${productController.getCartItems}",
                            size: Dimension.Height30 / 1.5,
                          ),
                          GestureDetector(
                            onTap: () {
                              productController.setQunatity(false);
                            },
                            child: Appicons(
                              icon: Icons.remove,
                              IconSize: Dimension.Height10 * 5,
                              size: Dimension.Width30,
                              colr: Colors.white,
                              backclor: AppColors.mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimension.Height10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimension.Height10, vertical: Dimension.Height10),
                      decoration: BoxDecoration(
                        color: AppColors.grayColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimension.Width30),
                          topLeft: Radius.circular(Dimension.Width30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: Dimension.Height30 * 1.5,
                            width: Dimension.Width30 * 3.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(Dimension.Width5 * 7),
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: AppColors.mainColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              productController.addItems(product);
                            },
                            child: Container(
                              height: Dimension.Height30 * 1.5,
                              width: Dimension.Width30 * 10,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(Dimension.Width5 * 7),
                              ),
                              child: Center(
                                child: BigText(
                                  text: "\$${price * productController.getCartItems}.00 | Add to cart",
                                  color: Colors.white,
                                  size: Dimension.Width30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      ),
      backgroundColor: Colors.white,
      body: _CustomScrollView(product,page),
    );
  }

  CustomScrollView _CustomScrollView(ProductsModel product,String page) {
    final String imageUrl = "${Constants.BASE_URL}uploads/${product.img}";
    String name = product.name ?? 'Example';
    String description = product.description ?? "Invalid description, 404 error not found";

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: Dimension.Height30 * 2,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {

                  if(page=="cart"){
                    Get.toNamed(Routeshelper.getFoodHomePageRoute(1));
                  }else{
                    Get.toNamed(Routeshelper.getFoodHomePageRoute(0));
                  }

                },
                child: const Appicons(icon: CupertinoIcons.back),
              ),
              const shoppingCartIcon(),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Dimension.Height10 * 2),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimension.Height15),
                  topLeft: Radius.circular(Dimension.Height15),
                ),
              ),
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: Dimension.Height10),
              child: Center(
                child: BigText(
                  text: name,
                  size: Dimension.Height10 * 3,
                ),
              ),
            ),
          ),
          pinned: true,
          backgroundColor: AppColors.yellowColor,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              imageUrl,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: Dimension.Width15 * 2),
            child: ExpandableText(
              description,
              expandText: 'show more',
              collapseText: 'show less',
              maxLines: 6,
              linkColor: Colors.blue[200],
            ),
          ),
        ),
      ],
    );
  }
}

