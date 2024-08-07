import 'package:get/get.dart';
import 'package:resturantapp/Routes/routesHelper.dart';
import 'package:resturantapp/widgets/snackbar.dart';

class ApiChecker {
  static void checker(int code,String text) {
    if (code == 401) {
      Get.toNamed(Routeshelper.getLoginPageRoute());
    } else {
      CustomSnackbar.showSnackbar(description: text);
    }
  }
}
