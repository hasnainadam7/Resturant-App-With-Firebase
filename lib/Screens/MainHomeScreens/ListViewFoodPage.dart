// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:resturantapp/utils/colors.dart';

import 'package:resturantapp/widgets/BigText.dart';
import 'package:resturantapp/widgets/SmallText.dart';
import 'package:resturantapp/widgets/ThreeIconsAndText.dart';

import '../../Routes/routesHelper.dart';
import '../../controller/product_repo_controller.dart';
import '../../models/product_models.dart';
import '../../utils/constants.dart';
import '../../utils/dimmensions.dart';
import '../../widgets/CustomLoadingBar.dart';

class ListViewContainer extends StatelessWidget {
  const ListViewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductRepoController>(builder: (context) {
      List<dynamic> products = context.getPopularProductList;

      int Items = products.length;
      return context.isloaded
          ? Container(
              // Container height is dynamic, calculated by the
              // product of total container image heights + total gap height and + 1

              height: Dimension.HomeListViewImageHeight * Items +
                  Dimension.Height10 * Items,
              padding: EdgeInsets.only(
                left: Dimension.Width30,
                right: Dimension.Width15,
              ),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Items,
                  itemBuilder: (context, index) {
                    return _ListColumn(products[index], index);
                  }),
            )
          : const Customloadingbar();
    });
  }

  Column _ListColumn(ProductsModel product, int index) {
    String imageUrl = product.img??"Erorr";
    String Name = product.name ?? 'Example';
    String Description =
        product.description ?? "invalid description 404 error not found";
    String Location = product.location ?? 'Canada, British Columbia';
    int Price = product.price ?? 120;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routeshelper.getPopularFoodRoute(index, "list"));
          },
          child: Row(
            children: [
              // Image Container
              Container(
                decoration: BoxDecoration(
                  color:  index%2==0 ? AppColors.blueColor:AppColors.purpleColor,
                    image: DecorationImage(
                        fit: BoxFit.cover, image:AssetImage(imageUrl)),
                    borderRadius:
                        BorderRadius.circular(Dimension.BorderRadius5)),
                width: Dimension.HomeListViewImageHeight,
                height: Dimension.HomeListViewImageHeight,
              ),
              // Description Container
              Container(
                height: Dimension.HomeListViewImageHeight,
                width: Dimension.HomeListViewTextWidth,
                padding: EdgeInsets.only(
                    bottom: Dimension.Height10, top: Dimension.Height10),
                child: Container(
                  padding: EdgeInsets.only(
                    left: Dimension.Width10 * 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimension.BorderRadius5 * 4),
                      bottomRight:
                          Radius.circular(Dimension.BorderRadius5 * 4),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: Name),
                      SmallText(text: Description),
                      ThreeIconAndText(
                        IconOneText: Price.toString(),
                        IconTwoText: Location,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: Dimension.Height10,
        ),
      ],
    );
  }
}
