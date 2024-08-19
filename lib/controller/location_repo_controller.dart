import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resturantapp/data/api/apiChecker.dart';
import 'package:http/http.dart' as http;
import 'package:resturantapp/data/repositories/location_repo.dart';
import 'package:resturantapp/models/geo_AddressModel.dart';
import 'package:resturantapp/models/response_model.dart';
import '../models/address_model.dart';

class LocationRepoController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationRepoController({required this.locationRepo});

  List<GeoCodeAddressModel> _googlePlacesList = [];
  List<GeoCodeAddressModel> get googlePlacesList => _googlePlacesList;

  bool loading = false;

  late Position _currentPosition;
  late Position _pickPosition;

  Position get pickPostion => _pickPosition;
  Position get currentPosition => _currentPosition;

  Placemark _currentPlacemark = const Placemark();
  Placemark _pickPlacemark = const Placemark();

  Placemark get currentPlacemark => _currentPlacemark;
  Placemark get pickPlacemark => _pickPlacemark;

  // For zone Base checking Variables
  bool _isLoading = false, _isZone = false, _isBtnDisabled = false;
  bool get isLoading => _isLoading;
  bool get isZone => _isZone;
  bool get isBtnDisabled => _isBtnDisabled;

  List<String> addressTypeList = ["home", "office", "others"];
  int addressTypeIndex = 0;

  int setAddressType(int index) {
    addressTypeIndex = index;
    update();
    return addressTypeIndex;
  }
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;
  // ignore: unused_field
  final bool _updateMapAddress = true;
  final bool _changeAddress = true;

  GoogleMapController setMapController(GoogleMapController mapController) {
    return _mapController = mapController;
  }

  Future<void> updatePosition(
      double latitude, double longitude, bool fromAddress) async {
    loading = true;
    if (fromAddress) {
      _currentPosition = Position(
        longitude: longitude,
        latitude: latitude,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        altitudeAccuracy: 1,
        heading: 1,
        headingAccuracy: 1,
        speed: 1,
        speedAccuracy: 1,
      );
    } else {
      _pickPosition = Position(
        longitude: longitude,
        latitude: latitude,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        altitudeAccuracy: 1,
        heading: 1,
        headingAccuracy: 1,
        speed: 1,
        speedAccuracy: 1,
      );
    }
    // ResponseModel getZoneResponseModel = await getZone(
    //     lat: latitude.toString(),
    //     long: longitude.toString(),
    //     markerLoad: false);
    // _isBtnDisabled = !getZoneResponseModel.isSuccuess;

    if (_changeAddress) {
      GeoCodeAddressModel? addressModel =
          await getAddressFromGeocode(LatLng(latitude, longitude));

      if (fromAddress && addressModel != null) {
        _currentPlacemark = Placemark(name: addressModel.displayName);
      } else {
        _pickPlacemark = Placemark(name: addressModel?.displayName);
      }
    }

    loading = false;
    update();
  }

  Future<GeoCodeAddressModel?> getAddressFromGeocode(LatLng latLng) async {
    loading = true;

    try {
      var res = await locationRepo.getAddressfromGeocode(latLng);
      if (res.body != null && res.statusCode == 200) {
        GeoCodeAddressModel geoaddressModel =
            GeoCodeAddressModel.fromJson(jsonDecode(res.body));
        loading = false;
        return geoaddressModel;
      } else {
        // Handle the case where the response body is null or status code isn't 200
        loading = false;
        return null;
      }
    } catch (e) {
      // Handle any exceptions that might occur
      print("Error fetching address from geocode: $e");
      loading = false;
      return null;
    }
  }

  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

  Future<ResponseModel> addUserAddress(AddressModel address) async {
    print(address.addressDescription);
    print(address.longitude);
    print(address.contactPersonNumber);
    print(address.addressType);
    print(address.contactPersonName);
    print(address.latitude);
    print(loading);
    loading = true;
    print(loading);
    ResponseModel res = await locationRepo.addUserAddress(address);
    print(loading);
    loading = false;
    print(loading);
    update();
    return res;
  }

  // Future<ResponseModel> getZone(
  //     {required String lat,
  //     required String long,
  //     required bool markerLoad}) async {
  //   late ResponseModel resModel;
  //
  //   // if (markerLoad) {
  //   //   _isLoading = true;
  //   // } else {
  //   //   _isLoading = false;
  //   // }
  //   update();
  //
  //   Response res = await locationRepo.getZone(lat, long);
  //   if (res.statusCode == 200) {
  //     _isZone = true;
  //     resModel = ResponseModel(true, res.body["zone-id"].toString());
  //   } else {
  //     _isZone = false;
  //     resModel = ResponseModel(true, res.statusText.toString());
  //   }
  //   update();
  //
  //   return resModel;
  // }

  Future<ResponseModel> getUserAddressList() async {
    loading = true;
    try {
      ResponseModel responseModel = await locationRepo.getUserAddressList();

      if (responseModel.data != null) {
        print(responseModel.data);
        _addressList = [];

        responseModel.data.forEach((address) {
          _addressList.add(AddressModel.fromJson(address));
        });
        print(addressList.last.addressDescription);
        update();
        loading = false;
        return ResponseModel(false, "Addresses loaded");
      } else {
        loading = false;
        update();
        return ResponseModel(true, "Address isnot loaded");
      }
    } catch (e) {
     return ResponseModel(false, e.toString());
    }
  }

  Future<List<GeoCodeAddressModel>> getSearchLocation(
      BuildContext context, String text) async {
    if (text.isEmpty) {
      return [];
    } else {
      // Response res = await locationRepo.getSearchLocation(text);

      final res = await http.get(Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$text&format=json'));
      print("IReacherd "+res.body);
      if (res.statusCode == 200) {
        _googlePlacesList = [];
        final List<dynamic> parsed = jsonDecode(res.body);
        for (dynamic data in parsed) {
          _googlePlacesList.add(GeoCodeAddressModel.fromJson(data));
        }
      } else {
        ApiChecker.checker(res.statusCode, res.body);
      }

      return _googlePlacesList;
    }
  }
}
