
import 'package:get/get_connect/http/src/response/response.dart';
// ignore: implementation_imports, depend_on_referenced_packages
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:resturantapp/data/api/apiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_address_model.dart';
import '../../../utils/constants.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> getAddressfromGeocode(LatLng latLng) async {
    return await apiClient.getData('${Constants.GEOCODE_API}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }



  Future<bool> saveUserAddress(String address) async {
    apiClient.updateToken(sharedPreferences.getString(Constants.TOKEN)!);


    bool user =
        await sharedPreferences.setString(Constants.USER_ADDRESS, address);

    return user;
  }

  String getUserAddress() {
    return sharedPreferences.getString(Constants.USER_ADDRESS) ?? "";
  }

  Future<Response> addUserAddress(UserAddressModel address) async {

    var response = await apiClient.postData(
      Constants.ADD_USER_ADDRESS_API,
      address.toJson(), // Make sure the body is encoded to JSON
    );

    // Handle the response as needed
    return response;
  }

  Future<Response> getUserAddressList() async {
    Response res = await apiClient.getData(Constants.GET_USER_ADDRESS_LIST_API);
    return res;
  }


  Future<Response> getSearchLocation(String text) async {
    Response res = await apiClient.getData("${Constants.AUTO_COMPLETE_PLACE_API}??query=$text");
    return res;
  }



  Future<Response> getZone(String lat,String long) async {
    Response res = await apiClient.getData("${Constants.ZONE_ID_API}?lat=$lat&lng=$long");
    return res;
  }
}
