class Products {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductsModel> _products;
  List<ProductsModel> get products=> _products;
  Products(
      {int? totalSize,
      int? typeId,
      int? offset,
      required List<ProductsModel> products}) {
    _products = products;
    _offset = offset;
    _typeId = typeId;
    _totalSize = totalSize;
  }
  Products.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductsModel>[];
      json['products'].forEach((v) {
        _products.add(ProductsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = _totalSize;
    data['type_id'] = _typeId;
    data['offset'] = _offset;

      data['products'] = _products.map((v) => v.toJson()).toList();

    return data;
  }
}

class ProductsModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? created_at;
  String? updated_at;
  String? product_type;

  ProductsModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
       this.product_type});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    product_type=json["product_type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['stars'] = stars;
    data['img'] = img;
    data['location'] = location;
    data['product_type'] = product_type;
    return data;
  }
}
