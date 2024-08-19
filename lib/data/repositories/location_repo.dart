import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_connect/http/src/response/response.dart';
// ignore: implementation_imports, depend_on_referenced_packages
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:resturantapp/data/api/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants.dart';
import '../../models/address_model.dart';
import '../../models/response_model.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  User? user = FirebaseAuth.instance.currentUser;
  LocationRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<dynamic> getAddressfromGeocode(LatLng latLng) async {
    String uri =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${latLng.latitude}&lon=${latLng.longitude}';
    final res = (await http.get(Uri.parse(uri)));
    return res;
  }

//Firebase
  Future<ResponseModel> addUserAddress(AddressModel address) async {
    ResponseModel responseModel;
    try {
      final user = this.user;
      // Get the document snapshot for the user

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'address': FieldValue.arrayUnion([address.toJson()])
        });
        responseModel = ResponseModel(true, "Address Added Successfully");
      } else {
        responseModel = ResponseModel(false, "User is not signed yet");
      }
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
    }
    return responseModel;
  }

  Future<ResponseModel> getUserAddressList() async {
    ResponseModel responseModel;
    try {
      final user = this.user;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      // Check if the document exists
      if (userDoc.exists) {
        // Get the 'address' field from the document
        List<dynamic> addressList = userDoc.get('address');

        // Process the address list
        for (var address in addressList) {
          // Assuming address.toJson() was used when adding, so you might need to convert it back to your address model
          print(address);
        }
        responseModel = ResponseModel(true,"List OF Address ",data: addressList);
      }else{
        responseModel = ResponseModel(false, "User not Signed yet");
      }

    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
    }
    return responseModel;
  }

  Future<Response> getSearchLocation(String text) async {
    Response res = await apiClient
        .getData("${Constants.AUTO_COMPLETE_PLACE_API}??query=$text");
    return res;
  }

  Future<Response> getZone(String lat, String long) async {
    Response res =
        await apiClient.getData("${Constants.ZONE_ID_API}?lat=$lat&lng=$long");
    return res;
  }
}
