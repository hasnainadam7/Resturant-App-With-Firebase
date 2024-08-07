import 'dart:core';

class AddressModel {
  int? placeId;

  String? lat;
  String? lon;

  String? type;

  String? addresstype;
  String? name;
  String? displayName;
  // Address? address;

  AddressModel({
    this.placeId,
    this.lat,
    this.lon,
    this.type,
    this.addresstype,
    this.name,
    this.displayName,
    // this.address,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];

    lat = json['lat'];
    lon = json['lon'];

    type = json['type'];

    addresstype = json['addresstype'];
    name = json['name'];
    displayName = json['display_name'];
    // address =
    //     json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place_id'] = placeId;

    data['lat'] = lat;
    data['lon'] = lon;

    data['type'] = type;
    data['addresstype'] = addresstype;
    data['name'] = name;
    data['display_name'] = displayName;
    // if (address != null) {
    //   data['address'] = address!.toJson();
    // }

    return data;
  }
}

class Address {
  String? road;
  String? neighbourhood;
  String? suburb;
  String? cityDistrict;
  String? city;
  String? state;
  String? iSO31662Lvl3;
  String? postcode;
  String? country;
  String? countryCode;

  Address(
      {this.road,
      this.neighbourhood,
      this.suburb,
      this.cityDistrict,
      this.city,
      this.state,
      this.iSO31662Lvl3,
      this.postcode,
      this.country,
      this.countryCode});

  Address.fromJson(Map<String, dynamic> json) {
    road = json['road'];
    neighbourhood = json['neighbourhood'];
    suburb = json['suburb'];
    cityDistrict = json['city_district'];
    city = json['city'];
    state = json['state'];
    iSO31662Lvl3 = json['ISO3166-2-lvl3'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['road'] = road;
    data['neighbourhood'] = neighbourhood;
    data['suburb'] = suburb;
    data['city_district'] = cityDistrict;
    data['city'] = city;
    data['state'] = state;
    data['ISO3166-2-lvl3'] = iSO31662Lvl3;
    data['postcode'] = postcode;
    data['country'] = country;
    data['country_code'] = countryCode;
    return data;
  }
}
