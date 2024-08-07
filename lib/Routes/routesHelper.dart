// ignore_for_file: file_names

import 'package:get/get.dart' ;
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:resturantapp/Screens/AddressPages/addAdress.dart';
import 'package:resturantapp/Screens/AuthenticationScreens/Login.dart';
import 'package:resturantapp/Screens/AuthenticationScreens/SignUp.dart';

import 'package:resturantapp/Screens/PopularFood/PopularFoodItem.dart';
import 'package:resturantapp/Screens/RecommendFood/RecommendFoodItem.dart';
import 'package:resturantapp/Screens/Splash/splashScreen.dart';
import '../Screens/AddressPages/fullMapScreen.dart';
import '../Screens/CartPage/cartPage.dart';
import '../Screens/MainHomeScreens/MainScreen.dart';

class Routeshelper {
  static const String initialRoute = "/";
  static const String popularFoodRoute = "/PopularFood";
  static const String recommendedFoodRoute = "/RecommendedFood";
  static const String cartRoute = "/cart";
  static const String foodPageRoute = "/foodPage";
  static const String loginRoute = "/loginPage";
  static const String registrationRoute = "/regisrationPage";
  static const String addressRoute = "/addressPage";
  static const String fullMapRoute = "/mapPage";

  static String getInitialRoute() => initialRoute;
  static String getPopularFoodRoute(int index, String page) => "$popularFoodRoute?pageId=$index&page=$page";
  static String getRecommendedFoodRoute(int index, String page) => "$recommendedFoodRoute?pageId=$index&page=$page";
  static String getCartRoute() => cartRoute;
  static String getFoodHomePageRoute(int index) => "$foodPageRoute?pageId=$index";

  static String getLoginPageRoute() => loginRoute;
  static String getRegisrationPageRoute() => registrationRoute;

  static String getAddressPageRoute() => addressRoute;
  static String geFullMapRoute() => fullMapRoute;

  static List<GetPage> routes = [
    GetPage(
      name: initialRoute,
      page: () => const SplashScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: foodPageRoute,
      page: () {
        final pageIdStr = Get.parameters["pageId"];

        int pageId = pageIdStr != null ? int.parse(pageIdStr) : 0;
        return MainScreen( controller: PersistentTabController(initialIndex: pageId));
        },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: popularFoodRoute,
      page: () {
        final pageIdStr = Get.parameters["pageId"];
        final page = Get.parameters["page"];
        if (pageIdStr == null || page == null) {
          return const PopularFoodDetails(pageId: 0, page: ""); // Default values
        }
        int pageId = int.parse(pageIdStr);
        return PopularFoodDetails(pageId: pageId, page: page);
      },
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: recommendedFoodRoute,
      page: () {
        final pageIdStr = Get.parameters["pageId"];
        final page = Get.parameters["page"];
        if (pageIdStr == null || page == null) {
          return const RecommendFood(pageId: 0, page: ""); // Default values
        }
        int pageId = int.parse(pageIdStr);
        return RecommendFood(pageId: pageId, page: page);
      },
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: cartRoute,
      page: () => Cartpage(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: loginRoute,
      page: () => Login(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: registrationRoute,
      page: () => SignUp(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: addressRoute,
      page: () =>  const AddAdress(),
      transition: Transition.leftToRight,
    ),

    GetPage(
      name: fullMapRoute,
      page: (){
        FullMap fullMapArguments= Get.arguments;
        return fullMapArguments;
  },
      transition: Transition.fade,
    ),
  ];
}
