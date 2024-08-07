import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:resturantapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/registration_models.dart';
import '../../api/apiClient.dart';



class AuthRepo {
  final ApiClient apiClient;

  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<UserCredential> registraion(CompleteRegistrationModel body) async {
  return await FirebaseAuth.instance.createUserWithEmailAndPassword(email: body.email, password: body.email);
  }

  Future<Response> login(String email, String password) async {
    // apiClient.setBasicAuth('admin', 'admin');
    return await apiClient
        .postData(Constants.AUTH_LOGIN_API, {"email": email, "password": password});
  }

  void signOut() {
    sharedPreferences.remove(Constants.TOKEN);
    sharedPreferences.remove(Constants.PHONE);
    sharedPreferences.remove(Constants.PASSWORD);
    apiClient.token = "";
    apiClient.updateToken("");
  }

  Future<bool> saveToken(String token) async {
    apiClient.token = token;
    apiClient.updateToken(token);
    return await sharedPreferences.setString(Constants.TOKEN, token);
  }

  Future<String> getToken() async {
    return sharedPreferences.getString(Constants.TOKEN) ?? "Null";
  }

  bool isUserLoggedIn() {

    return sharedPreferences.containsKey(Constants.TOKEN);
  }

  Future<void> saveUserNumberNPassword(String number, String pass) async {
    try {
      await sharedPreferences.setString(Constants.PHONE, number);
      await sharedPreferences.setString(Constants.PASSWORD, pass);
    } catch (e) {
      rethrow;
    }
  }
}
