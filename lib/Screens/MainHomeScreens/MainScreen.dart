// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";
import 'package:resturantapp/Screens/CartPage/cartPage.dart';
import 'package:resturantapp/Screens/MainHomeScreens/FoodPage.dart';
import 'package:resturantapp/controller/user_repo_controller.dart';

import 'package:resturantapp/utils/colors.dart';

import '../../controller/cart_repo_controller.dart';
import '../../controller/product_repo_controller.dart';

import '../CartHistoryPage/cartHistory.dart';
import '../ProfilePage/profilePage.dart';

class MainScreen extends StatelessWidget {
  final PersistentTabController controller;
  MainScreen({super.key, required this.controller});

  final List<Widget> pages = [
    const FoodPage(),

    Cartpage(),
    const CartHistoryMainPage(), // Placeholder for a future page
     const ProfilePage(), // Placeholder for a future page
  ];
  Future<void> _loadResources() async {
    await Get.find<ProductRepoController>().getPopularList();
    await Get.find<ProductRepoController>().getRecommendedList();
     Get.find<CartRepoController>().getCartData();
      Get.find<CartRepoController>().getCartHistoryData();
    await Get.find<UserRepoController>().getUserInfo();

  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadResources,
      child: PersistentTabView(
        controller: controller,
        tabs: [
          PersistentTabConfig(
            screen: pages[0],
            item: ItemConfig(
              activeForegroundColor: AppColors.mainColor,
              inactiveForegroundColor: AppColors.mainColor,
              icon: const Icon(Icons.home),
              title: "Home",
            ),
          ),
          PersistentTabConfig(
            screen: pages[1],
            item: ItemConfig(
              activeForegroundColor: AppColors.mainColor,
              inactiveForegroundColor: AppColors.mainColor,
              icon: const Icon(CupertinoIcons.cart),
              title: "Cart",
            ),
          ),
          PersistentTabConfig(
            screen: pages[2],
            item: ItemConfig(
              inactiveForegroundColor: AppColors.mainColor,
              activeForegroundColor: AppColors.mainColor,
              icon: const Icon(Icons.history),
              title: "History",
            ),
          ),
          PersistentTabConfig(
            screen: pages[3],
            item: ItemConfig(
              activeForegroundColor: AppColors.mainColor,
              inactiveForegroundColor: AppColors.mainColor,
              icon: const Icon(CupertinoIcons.person),
              title: "Profile",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style2BottomNavBar(
          navBarConfig: navBarConfig,
        ),
      ),
    );
  }
}
