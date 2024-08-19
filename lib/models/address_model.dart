class AddressModel {
  final double latitude;
  final double longitude;
  final String contactPersonName;
  final String contactPersonNumber;
  final String addressType;
  final String addressDescription;

  // Constructor
  AddressModel({
    required this.latitude,
    required this.longitude,
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.addressType,
    required this.addressDescription,
  });

  // Method for converting an JSON to Instance
  // Named constructor for creating an instance from JSON
  AddressModel.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude']?.toDouble(),
        longitude = json['longitude']?.toDouble(),
        contactPersonName = json['contactPersonName'],
        contactPersonNumber = json['contactPersonNumber'],
        addressType = json['addressType'],
        addressDescription = json['addressDescription'];

  // Method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'contactPersonName': contactPersonName,
      'contactPersonNumber': contactPersonNumber,
      'addressType': addressType,
      "addressDescription": addressDescription,
    };
  }
}
