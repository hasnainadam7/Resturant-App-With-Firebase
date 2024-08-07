class UserModel {
  String? name;
  String? email;
  String? phone;
  int id;
  int orderCount;

  UserModel(
      {this.email,
        this.phone,
        this.name,
        required this.id,
        required this.orderCount});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json["email"],
        phone: json["phone"],
        name: json["f_name"],
        id: json['id'],
        orderCount: json['order_count']);
  }
}
