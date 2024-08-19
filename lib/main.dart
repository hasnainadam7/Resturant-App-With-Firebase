import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:resturantapp/controller/auth_controller.dart';
import 'package:resturantapp/controller/cart_repo_controller.dart';
import 'package:resturantapp/controller/location_repo_controller.dart';
import 'package:resturantapp/controller/product_repo_controller.dart';
import 'package:resturantapp/utils/colors.dart';
import 'package:resturantapp/utils/constants.dart';
import 'Routes/routesHelper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'helper/dependency.dart' as dep;

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  Stripe.publishableKey = Constants.STRIPE_PK;
  Stripe.instance.applySettings();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(const Duration(milliseconds: 1000), () async {
    await dep.init();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductRepoController>(builder: (_) {
      return GetBuilder<AuthRepoController>(builder: (_) {
        return GetBuilder<LocationRepoController>(builder: (_) {
          return GetBuilder<CartRepoController>(builder: (_) {
            return GetMaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  textSelectionTheme: const TextSelectionThemeData(
                    selectionColor: AppColors.mainColor,
                    selectionHandleColor: AppColors.mainColor,
                  )),
              getPages: Routeshelper.routes,
            );
          });
        });
      });
    });
  }
}
