
import 'package:get/get.dart';
import 'package:resturantapp/controller/cart_repo_controller.dart';

import 'package:resturantapp/models/product_models.dart';


import '../data/repositories/laravel/popular_product_repo.dart';
import '../data/repositories/laravel/recommended_product_repo.dart';
import '../widgets/snackbar.dart';



class ProductRepoController extends GetxController {

  PopularProductRepo popularProductRepo ;
  RecommendedProductRepo recommendedProductRepo;
  ProductRepoController({required this.popularProductRepo,required this.recommendedProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get getPopularProductList => _popularProductList;

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get getrecommendedProductList => _recommendedProductList;

  bool _loaded = false;
  bool get isloaded => _loaded;

  int _quantity = 0;
  int get getQuantity {
    return _quantity;
  }

  int _cartItems = 0;
  int get getCartItems => _cartItems + _quantity;

  late CartRepoController _cartRepoController;

  Future<void> getPopularList() async {
    Response response = await popularProductRepo.getProductListRepo();

    if (response.statusCode == 200) {

      _popularProductList = [];
      _popularProductList.addAll(Products.fromJson(response.body).products);
      _loaded = true;
      update(); //similar as setState for updateing ui
    } else {}
  }
  Future<void> getRecommendedList() async {

    Response response = await recommendedProductRepo.getProductListRepo();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Products.fromJson(response.body).products);
      _loaded = true;
      update(); //similar as setState for updateing ui
    } else {}
  }



  void setQunatity(bool isIncremaent) {
    if (isIncremaent) {
      if (_quantity >= 20) {
        CustomSnackbar.showSnackbar(title: "Limit Reached", description:  "you cant select more",);

      } else {
        _quantity++;
      }
    } else if (_quantity <= 0) {
      CustomSnackbar.showSnackbar( title: "Items Count",  description: "you cant reduce more",);

    } else {
      _quantity--;
    }
    update();
  }

  void initProducts(ProductsModel product, CartRepoController cartController) {
    _quantity = 0;
    _cartItems = 0;
    _cartRepoController = cartController;
    bool exist = _cartRepoController.alreadyExisting(product);
    if (exist) {
      _quantity = _cartRepoController.getQuantity(product);
    }
    // update();
  }

  void addItems(ProductsModel model) {
    _cartRepoController.addItems(model, _quantity);
    // _cartRepoController.cartItems.forEach((key, val) {
    //   print("${key} +${val.quantity!}");
    // });

    update();
  }

  int get getTotalItemsQuantity{
    return _cartRepoController.getTotalQuantity;
  }
}
