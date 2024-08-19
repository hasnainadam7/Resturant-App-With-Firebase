class GeoCodeAddressModel {
  final String lat;
  final String lon;
  final String name;
  final String displayName;

  // Constructor to initialize the fields
  GeoCodeAddressModel({
    required this.lat,
    required this.lon,
    required this.name,
    required this.displayName,
  });

  // Named constructor for creating an instance from JSON
  GeoCodeAddressModel.fromJson(Map<String, dynamic> json)
      : lat = json['lat'],
        lon = json['lon'] ,
        name = json['name'] ,
        displayName = json['display_name'] ;
}
