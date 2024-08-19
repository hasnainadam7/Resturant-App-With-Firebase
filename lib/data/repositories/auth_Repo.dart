import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:resturantapp/models/response_model.dart';
import 'package:resturantapp/models/user_model.dart';
import 'package:resturantapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/registration_models.dart';
import '../api/apiClient.dart';

class AuthRepo {
  final ApiClient apiClient;


  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<ResponseModel> registration(RegistrationModel body) async {
    ResponseModel responseModel;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: body.email.trim(),
        password: body.password.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        await saveUID(user.uid);
        await user.updateDisplayName(body.f_name.trim());
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set({
          'displayName': body.f_name.trim(),
          'photoURL': "",
          "orderCount": 0,
          'phoneNumber': body.phone.trim(),
          'address': [],
          'email': body.email.trim(),
        });
      }
      // print("I am  $userCredential");
      responseModel = ResponseModel(true, "Account Created Successfully");
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'The email address is already in use.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled.';
          break;
        case 'weak-password':
          message = 'The password is too weak.';
          break;
        default:
          message = 'An unknown error occurred.';
      }
      responseModel = ResponseModel(false, message);
    }
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    ResponseModel responseModel;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveUID(userCredential.user!.uid);
      responseModel = ResponseModel(true, "Account Logged-In Successfully");
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided for that user.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'user-disabled':
          message = 'The user account has been disabled by an administrator.';
          break;
        case 'too-many-requests':
          message = 'Too many requests. Try again later.';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled.';
          break;
        default:
          message = 'An unknown error occurred.';
      }
      // Display the error message to the user
      responseModel = ResponseModel(false, message);
    }
    return responseModel;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    sharedPreferences.remove(Constants.UID);
  }

  Future<void> saveUID(String value) async {
    await sharedPreferences.setString(Constants.UID, value);
  }

    Future<bool> isUserSigned() async {
    return  sharedPreferences.containsKey(Constants.UID);
  }
  Future<String?> getUID() async {
    if (sharedPreferences.containsKey(Constants.UID)) {
      return sharedPreferences.getString(Constants.UID);
    }
    return null;
  }

  Future<UserModel?> getUserData() async {
    try {
      String? uid = await getUID();
      if (uid!.isNotEmpty) {
        DocumentSnapshot documentSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (documentSnapshot.exists) {
        UserModel  userModel = UserModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>);
          return userModel;
        }
      } else {
        print("User not signed :");
      }
    } catch (e) {
      print("Error getting document: $e");
    }
    return null;
  }


}
