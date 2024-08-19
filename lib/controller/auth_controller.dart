import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:resturantapp/models/registration_models.dart';
import 'package:resturantapp/models/response_model.dart';
import 'package:resturantapp/models/user_model.dart';

import '../data/repositories/auth_Repo.dart';

class AuthRepoController extends GetxController implements GetxService {
  AuthRepo authRepo;
  late UserModel? _userModel =null;
  UserModel? get userModel =>  _userModel;
  AuthRepoController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(RegistrationModel registration) async {

    _isLoading = true;
    ResponseModel res = await authRepo.registration(registration);
    _isLoading = false;
    update();
    return res;
  }

  Future<UserModel?> getUserData() async {

    _userModel = await authRepo.getUserData();

    update();
    return _userModel;
  }

  Future<ResponseModel> login(String email, password) async {
    _isLoading = true;
    ResponseModel res = await authRepo.login(email, password);
    _isLoading = false;
    update();
    return res;
  }
  Future<String?> getUID() {
   return  authRepo.getUID();
  }

  void signOut() {
    authRepo.signOut();
    update();
  }

  Future<bool> isUserSigned() async {
    return await authRepo.isUserSigned();
  }
}
