// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturantapp/Routes/routesHelper.dart';
import 'package:resturantapp/controller/auth_controller.dart';
import 'package:resturantapp/controller/location_repo_controller.dart';

import 'package:resturantapp/utils/dimmensions.dart';

import '../../controller/cart_repo_controller.dart';
import '../../controller/product_repo_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  void _loadResources() async {
    await Get.find<ProductRepoController>().getPopularList();
    await Get.find<ProductRepoController>().getRecommendedList();
    Get.find<CartRepoController>().getCartData();

    await Get.find<AuthRepoController>().getUserData();

    await Get.find<LocationRepoController>().getUserAddressList();
   await Get.find<LocationRepoController>().getUserAddressList();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  initState() {
    super.initState();

    _loadResources();

    // TODO: implement initState
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Future.delayed(const Duration(seconds: 3), () {

      Navigator.pushReplacementNamed(context, Routeshelper.getFoodHomePageRoute(3));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset(
                "assets/images/logo part 1.png",
                width: Dimension.Width30 * 15,
              ))),
          Center(
              child: Image.asset(
            "assets/images/logo part 2.png",
            width: Dimension.Width30 * 15,
          ))
        ],
      ),
    );
  }
}
