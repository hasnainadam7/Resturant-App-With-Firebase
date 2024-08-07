import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:resturantapp/data/repositories/laravel/user_repo.dart';
import 'package:resturantapp/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/response_model.dart';
import '../utils/constants.dart';

class UserRepoController extends GetxController implements GetxService {
  UserRepo userRepo;
  UserRepoController({
    required this.sharedPreferences,
    required this.userRepo,
  });

  late UserModel _userModel ;
  UserModel get userModel => _userModel;
  final SharedPreferences sharedPreferences;


  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<ResponseModel> getUserInfo() async {
    _isLoading = true;
    if (sharedPreferences.containsKey(Constants.TOKEN)) {
      String? token = sharedPreferences.getString(Constants.TOKEN);
      if (token != null) {
        userRepo.updateToken(token);
      }
    }
    Response res = await userRepo.getUserInfo();
    late ResponseModel responseModel;

    if (res.statusCode == 200) {

      _userModel = UserModel.fromJson(res.body);

      responseModel = ResponseModel(true,"Successfully done");
    } else {
      responseModel = ResponseModel(
          false,
          "${res.statusText!}  ${res.status} ${res.statusCode}");
    }
    _isLoading = false;
    update();

    return responseModel;
  }
}
