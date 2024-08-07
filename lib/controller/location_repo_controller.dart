import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resturantapp/data/api/apiChecker.dart';
import 'package:http/http.dart' as http;
import 'package:resturantapp/data/repositories/laravel/location_repo.dart';
import 'package:resturantapp/models/response_model.dart';
import 'package:resturantapp/models/user_address_model.dart';
import '../models/address_model.dart';

class LocationRepoController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationRepoController({required this.locationRepo});

  List<AddressModel> _googlePlacesList = [];
  List<AddressModel> get googlePlacesList => _googlePlacesList;

  bool loading = false;

  UserAddressModel? _userAddressModel;
  UserAddressModel? get userAddressModel => _userAddressModel;

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

  late List<UserAddressModel> _allAddressList;
  List<UserAddressModel> get allAddressList => _allAddressList;
  List<String> addressTypeList = ["home", "office", "others"];
  int addressTypeIndex = 0;

  int setAddressType(int index) {
    addressTypeIndex = index;
    update();
    return addressTypeIndex;
  }

  late List<UserAddressModel> _addressList = [];
  List<UserAddressModel> get addressList => _addressList;

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
    ResponseModel getZoneResponseModel = await getZone(
        lat: latitude.toString(),
        long: longitude.toString(),
        markerLoad: false);
    _isBtnDisabled = !getZoneResponseModel.isSuccuess;

    if (_changeAddress) {
      AddressModel? addressModel =
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

  Future<AddressModel?> getAddressFromGeocode(LatLng latLng) async {
    loading = true;
    // await Future.delayed(const Duration(seconds: 5));
    // Response res = await locationRepo.getAddressfromGeocode(latLng);
    final res = (await http.get(Uri.parse(
            'https://nominatim.openstreetmap.org/reverse?format=json&lat=${latLng.latitude}&lon=${latLng.longitude}')));


    AddressModel? addressModel;

    // ignore: unnecessary_null_comparison
    if (res.body != null) {
      addressModel = AddressModel.fromJson(jsonDecode(res.body));
    }

    getUserAddress();
    loading = true;

    return addressModel;
  }

  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

  UserAddressModel? getUserAddress() {
    if (locationRepo.getUserAddress().isNotEmpty) {
      String addressString = locationRepo.getUserAddress();
      _getAddress = jsonDecode(addressString);
      // ignore: unnecessary_null_comparison
      if (_getAddress != null) {
        _userAddressModel = UserAddressModel.fromJson(_getAddress);
        return _userAddressModel;
      }
    }

    return null;
  }

  Future<ResponseModel> addUserAddress(UserAddressModel address) async {
    loading = true;

    Response res = await locationRepo.addUserAddress(address);

    ResponseModel responseModel;
    if (res.statusCode == 200) {
      saveUserAddress(address);

      responseModel = ResponseModel(false, "Address Saved Successfully");
    } else {
      responseModel = ResponseModel(true, res.body);
    }

    loading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getZone(
      {required String lat,
      required String long,
      required bool markerLoad}) async {
    late ResponseModel resModel;

    if (markerLoad) {
      _isLoading = true;
    } else {
      _isLoading = false;
    }
    update();

    Response res = await locationRepo.getZone(lat, long);
    if (res.statusCode == 200) {
      _isZone = true;
      resModel = ResponseModel(true, res.body["zone-id"].toString());
    } else {
      _isZone = false;
      resModel = ResponseModel(true, res.statusText.toString());
    }
    update();

    return resModel;
  }

  Future<ResponseModel> getUserAddressList() async {
    loading = true;

    Response res = await locationRepo.getUserAddressList();
    if (res.statusCode == 200) {
      _allAddressList = [];
      _addressList = [];
      res.body.forEach((address) {
        _allAddressList.add(UserAddressModel.fromJson(address));

        _addressList.add(UserAddressModel.fromJson(address));
      });
      update();
      loading = false;
      return ResponseModel(false, "Addresses loaded");
    } else {
      loading = false;
      update();
      return ResponseModel(true, "Address isnt loaded");
    }
  }

  Future<void> saveUserAddress(UserAddressModel userAddressModel) async {
    String data = jsonEncode(userAddressModel.toJson());
    await locationRepo.saveUserAddress(data);
  }

  Future<List<AddressModel>> getSearchLocation(
      BuildContext context, String text) async {
    if (text.isEmpty) {
      return [];
    } else {
      // Response res = await locationRepo.getSearchLocation(text);

      final res = await http.get(Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$text&format=json'));
      if (res.statusCode == 200) {
        _googlePlacesList = [];
        final List<dynamic> parsed = jsonDecode(res.body);
        for (dynamic data in parsed) {
          _googlePlacesList.add(AddressModel.fromJson(data));
        }
      } else {
        ApiChecker.checker(res.statusCode, res.body);
      }

      return _googlePlacesList;
    }
  }
}
