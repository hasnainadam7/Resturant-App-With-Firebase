// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturantapp/utils/dimmensions.dart';
import 'package:resturantapp/widgets/BigText.dart';
import 'package:resturantapp/widgets/SmallText.dart';
import '../../Routes/routesHelper.dart';
import '../../base/no_data_cart.dart';
import '../../controller/cart_repo_controller.dart';
import '../../models/cart_models.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/AppIcons.dart';
import 'package:intl/intl.dart';

class CartHistoryMainPage extends StatelessWidget {
   const CartHistoryMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartRepoController>(
      builder: (controller) {
        List<CartModel> updatedHistory =
            controller.getCartHistoryData().reversed.toList();


        // Map to store the count of items per order time
        Map<String, int> cartHistoryItemsPerOrder = {};
        for (var item in updatedHistory) {
          String orderTime = item.time ?? ''; // Ensure time is not null
          if (cartHistoryItemsPerOrder.containsKey(orderTime)) {
            cartHistoryItemsPerOrder.update(orderTime, (val) => val + 1);
          } else {
            cartHistoryItemsPerOrder.putIfAbsent(orderTime, () => 1);
          }
        }
        List<String> orderTimes = cartHistoryItemsPerOrder.entries.map((val) => val.key).toList();

        int ImgCounter = -1;


        return updatedHistory.isNotEmpty ? Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(color: Colors.white, text: "Your Cart History"),
                Appicons(
                  icon: CupertinoIcons.shopping_cart,
                  colr: Colors.white,
                  backclor: Colors.transparent,
                  size: 30,
                )
              ],
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(
                left: Dimension.Width30,
                right: Dimension.Width30,
                bottom: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // for (var entry in cartHistoryItemsPerOrder.entries)
    for (int i = 0; i < cartHistoryItemsPerOrder.entries.length; i++)
        // var entry = cartHistoryItemsPerOrder.entries.elementAt(i);
                    // for(int i =0 ;i < cartHistoryItemsPerOrder.l)
                    Container(
                      padding: EdgeInsets.only(
                          bottom: Dimension.Width30,
                          top: Dimension.Width10),
                      decoration: const BoxDecoration(
                          // Add your decoration if needed

                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (() {
                            DateTime outformed;
                            String formattedDate;
                            try {
                              outformed = DateTime.parse(cartHistoryItemsPerOrder.entries.elementAt(i).key);
                              formattedDate = DateFormat('yyyy/MM/dd hh:mm a')
                                  .format(outformed);
                            } catch (e) {

                              // Handle the error, maybe set a default value or show an error message
                              formattedDate = "Invalid date";
                            }

                            return BigText(
                              text: formattedDate,
                              size: Dimension.Height15 * 1.4,
                            );
                          }()),

                          // BigText(
                          //   text: entry.key.isEmpty
                          //       ? 'Unknown Time'
                          //       : entry.key.substring(0, 16),
                          //   // Format the time as per your requirement
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 4,
                                children: List.generate(
                                  cartHistoryItemsPerOrder.entries.elementAt(i).value,
                                  // entry.value>3 ? 3 : entry.value,
                                  (index) {
                                    if (ImgCounter < updatedHistory.length) {
                                      ImgCounter++;
                                    }
                                    return index <= 2
                                        ? Container(
                                            height:
                                                Dimension.HistoryIMGSHeight,
                                            width: Dimension.HistoryIMGSWidth,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimension.Height15),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        Constants.IMG_URL_API +
                                                            updatedHistory[
                                                                    ImgCounter]
                                                                .img!))),
                                            // color: Colors.blue,
                                          )
                                        : Container();
                                  },
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SmallText(
                                    text: "Total",
                                    color: Colors.black,
                                  ),
                                  BigText(

                                      text: cartHistoryItemsPerOrder.entries.elementAt(i).value == 1
                                          ? "${cartHistoryItemsPerOrder.entries.elementAt(i).value} Item"
                                          : "${cartHistoryItemsPerOrder.entries.elementAt(i).value} Items"),
                                  SizedBox(
                                      height: 30,
                                      width: 70,
                                      child: OutlinedButton(
                                        onPressed: () {

                                          for (var item in updatedHistory) {
                                            if(item.time==orderTimes[i]){
                                              Get.find<CartRepoController>()
                                                      .addItems(item.product!,
                                                          item.quantity!);
                                            }
                                          }

                                          Get.toNamed(Routeshelper.getFoodHomePageRoute(1));

                                        },
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              color: AppColors.mainColor),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    Dimension.Width10),
                                          ),
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: SmallText(
                                          text: 'One more',
                                          color: AppColors.mainColor,
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ) : const Scaffold(
            body:
            NoDataImgCart(text: 'You didnt buy anything so far',ImgPath: "assets/image/empty_box.png",));
      },
    );
  }
}
