import 'package:get/get.dart';
import 'package:resturantapp/controller/auth_controller.dart';
import 'package:resturantapp/controller/location_repo_controller.dart';
import 'package:resturantapp/controller/payment_repo_controller.dart';
import 'package:resturantapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/cart_repo_controller.dart';
import '../controller/product_repo_controller.dart';
import '../data/api/apiClient.dart';
import '../data/repositories/auth_Repo.dart';
import '../data/repositories/cart_repo.dart';
import '../data/repositories/location_repo.dart';
import '../data/repositories/payment_repo.dart';
import '../data/repositories/popular_product_repo.dart';
import '../data/repositories/recommended_product_repo.dart';

Future<void> init() async {
  // Obtain shared preferences.
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  Get.lazyPut(() => prefs);
  // Registering ApiClient
  Get.lazyPut(
    () => ApiClient(appBaseUrl: Constants.BASE_URL),
  );

  // Registering repositories
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => PaymentRepo());

  // Registering controllers
  Get.lazyPut(() => AuthRepoController(authRepo: Get.find()));
  Get.lazyPut(() => ProductRepoController(
      popularProductRepo: Get.find(), recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartRepoController(cartRepo: Get.find()));

  Get.lazyPut(() => LocationRepoController(locationRepo: Get.find()));
  Get.lazyPut(() => PaymentRepoController(paymentRepo: Get.find()));
}
