import 'address_model.dart';

class UserModel {
  String? photoURL;
  String? phoneNumber;
  String? displayName;
  int? orderCount;
  String? email;

  UserModel(
      {this.photoURL,
        this.phoneNumber,
        // this.address,
        this.displayName,
        this.orderCount,
        this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    photoURL = json['photoURL'];
    phoneNumber = json['phoneNumber'];
    displayName = json['displayName'];
    orderCount = json['orderCount'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoURL'] = photoURL;
    data['phoneNumber'] = phoneNumber;
     data['displayName'] = displayName;
    data['orderCount'] = orderCount;
    data['email'] = email;
    return data;
  }
}
