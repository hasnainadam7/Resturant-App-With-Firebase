// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturantapp/controller/auth_controller.dart';
import 'package:resturantapp/controller/cart_repo_controller.dart';
import 'package:resturantapp/controller/location_repo_controller.dart';
import 'package:resturantapp/controller/payment_repo_controller.dart';
import 'package:resturantapp/controller/product_repo_controller.dart';
import 'package:resturantapp/models/cart_models.dart';
import 'package:resturantapp/models/response_model.dart';
import 'package:resturantapp/utils/colors.dart';
import 'package:resturantapp/utils/dimmensions.dart';
import 'package:resturantapp/widgets/AppIcons.dart';

import '../../Routes/routesHelper.dart';
import '../../base/no_data_cart.dart';
import '../../utils/constants.dart';
import '../../widgets/BigText.dart';
import '../../widgets/ShoppingCartIcon.dart';
import '../../widgets/SmallText.dart';
import '../../widgets/snackbar.dart';
import '../PaymentScreen/Payment.dart';

class Cartpage extends StatelessWidget {
  Cartpage({super.key});

  var product = Get.find<CartRepoController>().cartItems;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartRepoController>(builder: (cartRepoController) {
      if (cartRepoController.getcartItems.isNotEmpty) {
        return Scaffold(
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(top: Dimension.Height10),
            margin: EdgeInsets.only(
                left: Dimension.Width10 * 2,
                right: Dimension.Width10 * 2,
                bottom: Dimension.Height30 * 1.5),
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimension.Height10,
                  right: Dimension.Height10,
                  top: Dimension.Height10,
                  bottom: Dimension.Height10),
              decoration: BoxDecoration(
                color: AppColors.grayColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimension.Width30),
                    topLeft: Radius.circular(Dimension.Width30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: Dimension.Height30 * 1.5,
                      width: Dimension.Width30 * 7,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimension.Width5 * 7)),
                      child: Center(
                          child: BigText(
                        text: "\$ ${cartRepoController.getTotalAmmount}.0",
                      ))),
                  Container(
                      height: Dimension.Height30 * 1.5,
                      width: Dimension.Width30 * 10,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimension.Width5 * 7)),
                      child: GestureDetector(
                        onTap: () async {
                          print("Am i here");
                          if (Get.find<AuthRepoController>().isUserLoggedIn()) {
                            if (Get.find<LocationRepoController>()
                                .addressList
                                .isEmpty) {
                              Get.toNamed(Routeshelper.getAddressPageRoute());
                            } else {
                              try {
                                ResponseModel res =
                                    await Get.find<PaymentRepoController>()
                                        .makePayment();

                                if (!res.isSuccuess) {
                                  CustomSnackbar.showSnackbar(
                                      title: "Payment",
                                      description: res.message,
                                      duration: 3);
                                } else if (res.isSuccuess) {
                                  CustomSnackbar.showSnackbar(
                                      description: "Payment Successfully done ",
                                      duration: 3,
                                      isError: false,
                                      title: "Payment");
                                  Get.find<CartRepoController>().CheckOut();
                                }
                              } catch (e) {}
                            }
                          } else {
                            Get.toNamed(Routeshelper.getLoginPageRoute());
                          }
                        },
                        child: Center(
                            child: BigText(
                          // text: "\$${price * context.getCartItems} | Add to cart",
                          text: "Check out ",

                          color: Colors.white,
                          size: Dimension.Width30,
                        )),
                      ))
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimension.Width30,
                      top: Dimension.Height15,
                      right: Dimension.Width30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routeshelper.foodPageRoute);
                        },
                        child: const Appicons(
                          icon: CupertinoIcons.back,
                          backclor: AppColors.mainColor,
                          colr: Colors.white,
                        ),
                      ),
                      const shoppingCartIcon(),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimension.Width15,
                        top: Dimension.Height15,
                        right: Dimension.Width15),
                    child: ListView.builder(
                      itemCount: cartRepoController.getcartItems.length,
                      itemBuilder: (context, index) {
                        CartModel cartItem =
                            cartRepoController.getcartItems[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                // Image Container
                                GestureDetector(
                                  onTap: () {
                                    int popularIndex =
                                        Get.find<ProductRepoController>()
                                            .getPopularProductList
                                            .indexOf(cartItem.product);
                                    int recommendedIndex =
                                        Get.find<ProductRepoController>()
                                            .getrecommendedProductList
                                            .indexOf(cartItem.product);
                                    if (popularIndex >= 0) {
                                      Get.toNamed(
                                          Routeshelper.getPopularFoodRoute(
                                              popularIndex, "cart"));
                                    } else if (recommendedIndex >= 0) {
                                      Get.toNamed(
                                          Routeshelper.getRecommendedFoodRoute(
                                              recommendedIndex, "cart"));
                                    } else {
                                      CustomSnackbar.showSnackbar(
                                          title: "History Products",
                                          description:
                                              "Descrription isnt available of history products",
                                          isError: false);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "${Constants.BASE_URL}uploads/${cartItem.img}"),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          Dimension.BorderRadius5),
                                    ),
                                    width: Dimension.HomeListViewImageHeight,
                                    height: Dimension.HomeListViewImageHeight,
                                  ),
                                ),
                                // Description Container
                                Container(
                                  height: Dimension.HomeListViewImageHeight,
                                  width: Dimension.MobileWidth / 1.7,
                                  padding: EdgeInsets.only(
                                    bottom: Dimension.Height10,
                                    top: Dimension.Height10,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: Dimension.Width10 * 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            Dimension.BorderRadius5 * 4),
                                        bottomRight: Radius.circular(
                                            Dimension.BorderRadius5 * 4),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(text: cartItem.name!),
                                        SmallText(text: "Spices"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text:
                                                  "\$ ${cartItem.price! * cartItem.quantity!}.0",
                                              color: Colors.redAccent,
                                            ),
                                            Container(
                                              height: Dimension.Height30 * 1.3,
                                              width: Dimension.Height30 * 2.5,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  // color: Colors.red,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        offset: Offset(1, 1),
                                                        blurRadius: 3)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimension.Width5 *
                                                              3)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    height: Dimension.Height30 *
                                                        1.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimension.Width5 *
                                                                  2),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        int quantity =
                                                            cartItem.quantity!;
                                                        quantity++;
                                                        cartRepoController
                                                            .addItems(
                                                                cartItem
                                                                    .product!,
                                                                quantity);
                                                        // cartRepoController
                                                        //     .updateQuantity(
                                                        //     cartItem,
                                                        //     quantity);
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: AppColors
                                                            .mainBlackColor,
                                                      ),
                                                    ),
                                                  ),
                                                  BigText(
                                                      size: Dimension.Height30 /
                                                          1.7,
                                                      text: cartItem.quantity!
                                                          .toString(),
                                                      color: Colors.black),
                                                  Container(
                                                      height:
                                                          Dimension.Height30,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimension
                                                                      .Width5 *
                                                                  2)),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          int quantity =
                                                              cartItem
                                                                  .quantity!;
                                                          quantity--;
                                                          cartRepoController
                                                              .addItems(
                                                                  cartItem
                                                                      .product!,
                                                                  quantity);
                                                        },
                                                        child: const Icon(
                                                            color: AppColors
                                                                .mainBlackColor,
                                                            CupertinoIcons
                                                                .minus),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimension.Height10,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return const Scaffold(
            body: NoDataImgCart(
          text: 'Cart is empty right now',
          clr: AppColors.BrownColr,
        ));
      }
    });
  }
}
