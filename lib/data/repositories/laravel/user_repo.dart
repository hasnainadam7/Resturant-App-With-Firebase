import 'package:get/get_connect/http/src/response/response.dart';
import 'package:resturantapp/data/api/apiClient.dart';
import 'package:resturantapp/utils/constants.dart';

class UserRepo {
  ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {

    return await apiClient.getData(Constants.USER_INFO_API);
  }
  void updateToken(String token) {
    apiClient.updateToken(token);
  }

}
