// ignore_for_file: file_names, camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Routes/routesHelper.dart';
import '../controller/cart_repo_controller.dart';
import '../controller/product_repo_controller.dart';
import '../utils/colors.dart';
import '../utils/dimmensions.dart';
import 'AppIcons.dart';
import 'BigText.dart';

class shoppingCartIcon extends StatelessWidget {
  const shoppingCartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductRepoController>(builder: (productRepoController) {
      return GestureDetector(

        onTap: () {

          Get.toNamed(Routeshelper.getFoodHomePageRoute(1));
        },
        child: GetBuilder<CartRepoController>(builder: (cartRepoController) {
          return Stack(
            children: [
              const Appicons(
                icon: CupertinoIcons.shopping_cart,
                backclor: AppColors.mainColor,
                colr: Colors.white,
              ),
              cartRepoController.getTotalQuantity > 0
                  ? Positioned(
                      top: 0,
                      right: 0,
                      height: Dimension.Height10 * 2,
                      width: Dimension.Height10 * 2,
                      child: const Appicons(
                        icon: CupertinoIcons.circle_fill,
                        colr: Colors.white,
                      ),
                    )
                  : Container(),
              cartRepoController.getTotalQuantity > 0
                  ? Positioned(
                      top: 0,
                      right: 0,
                      height: Dimension.Height10 * 2,
                      width: Dimension.Height10 * 2,
                      child: Center(
                          child: BigText(
                        size: Dimension.Height10,
                        text: cartRepoController.getTotalQuantity.toString(),
                        color: AppColors.mainColor,
                      )))
                  : Container()
            ],
          );
        }),
      );
    });
  }
}
