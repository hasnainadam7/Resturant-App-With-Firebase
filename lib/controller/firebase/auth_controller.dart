
import 'package:get/get.dart';
import 'package:resturantapp/models/registration_models.dart';
import 'package:resturantapp/models/response_model.dart';

import '../../data/repositories/firebase/auth_Repo.dart';



class AuthRepoController extends GetxController implements GetxService {
  AuthRepo authRepo;

  AuthRepoController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> registration(
      CompleteRegistrationModel registration) async {
    _isLoading = true;
    final res = await authRepo.registraion(registration);
    print(res);
    // late ResponseModel responseModel;
    // if (res.statusCode == 200) {
    //
    //   authRepo.saveToken(res.body["token"]);
    //   responseModel = ResponseModel(true, res.body["token"]);
    // } else {
    //   responseModel = ResponseModel(false,
    //       res.statusText! + res.status.toString() + res.statusCode.toString());
    // }
    // _isLoading = false;
    // print(responseModel.message);
    update();
    // return responseModel;
  }
  Future<ResponseModel> login(String email, password) async {

    _isLoading = true;
    Response res = await authRepo.login(email, password);
    late ResponseModel responseModel;
    if (res.statusCode == 200) {
      authRepo.saveToken(res.body["token"]);

      responseModel = ResponseModel(true, res.body["token"]);
    } else {
      responseModel = ResponseModel(false,
          res.statusText! + res.status.toString() + res.statusCode.toString());
    }
    _isLoading = false;

    update();
    return responseModel;
  }

  void signOut(){
    authRepo.signOut();
    update();
  }
  void saveUserNumberNPassword(String number, String pass) {
    authRepo.saveUserNumberNPassword(number, pass);
  }

  bool isUserLoggedIn()  {
    return authRepo.isUserLoggedIn();
  }
  void intializedToken(){
    if(isUserLoggedIn()){

    }
  }
  Future<String> getToken()  async {
    return  await authRepo.getToken();
  }
}
