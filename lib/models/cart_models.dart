import 'package:resturantapp/models/product_models.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  String? location;
  String? time;
  int? quantity;
  bool? isAvailable;
  ProductsModel? product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.location,
    this.time,
    this.quantity,
    this.isAvailable,
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    isAvailable = json['isAvailable'];
    price = json['price'];
    img = json['img'];
    location = json['location'];
    time = json['time'];
    product = json['product'] != null ? ProductsModel.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['quantity'] = quantity;
    data['isAvailable'] = isAvailable;
    data['price'] = price;
    data['img'] = img;
    data['location'] = location;
    data['time'] = time;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
