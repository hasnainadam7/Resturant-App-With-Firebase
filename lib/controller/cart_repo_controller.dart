// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:resturantapp/models/product_models.dart';
import 'package:resturantapp/utils/constants.dart';

import 'package:resturantapp/widgets/snackbar.dart';

import '../data/repositories/cart_repo.dart';
import '../models/cart_models.dart';

class CartRepoController extends GetxController {
  CartRepo cartRepo;

  CartRepoController({required this.cartRepo});

  Map<int, CartModel> _cartItems = {};
  Map<int, CartModel> get cartItems => _cartItems;

  Map<int, CartModel> _cartHistoryItems = {};
  Map<int, CartModel> get cartHistoryItems => _cartHistoryItems;

  List<CartModel> storageItems = [];
  List<CartModel> storageHistoryItems = [];
  List<String> CartHistory = [];

  void addItems(ProductsModel product, int quantity) {
    if (quantity > 20) {
      CustomSnackbar.showSnackbar(
          title: "Limit Reached", description: "Only 20 items at a time");
    } else {
      if (_cartItems.containsKey(product.id!)) {
        _cartItems.update(product.id!, (value) {
          return CartModel(
              id: product.id,
              name: value.name,
              price: value.price,
              quantity: quantity,
              isAvailable: true,
              img: value.img,
              location: value.location,
              time: DateTime.now().toString(),
              product: product);
        });
        if (quantity + _cartItems[product.id]!.quantity! <= 0) {
          _cartItems.remove(product.id!);
        }
      } else {
        _cartItems.putIfAbsent(
          product.id!,
          () {
            return CartModel(
                id: product.id,
                name: product.name,
                price: product.price,
                quantity: quantity,
                isAvailable: true,
                img: product.img,
                location: product.location,
                time: DateTime.now().toString(),
                product: product);
          },
        );
      }
    }

    cartRepo.addToCartList(getcartItems);
    update();
  }

  bool alreadyExisting(ProductsModel product) {
    if (_cartItems.containsKey(product.id!)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductsModel product) {
    var quantity = 0;

    if (_cartItems.containsKey(product.id!)) {
      _cartItems.forEach(
        (key, value) {
          if (key == product.id) {
            quantity = value.quantity!;
          }
        },
      );
    }
    return quantity;
  }

  int get getTotalQuantity {
    int totalItemsQuantity = 0;
    _cartItems.forEach((key, val) {
      totalItemsQuantity += val.quantity!;
    });
    return totalItemsQuantity;
  }

  int get getTotalAmmount {
    int totalItemsAmmount = 0;
    _cartItems.forEach((key, val) {
      totalItemsAmmount += (val.price! * val.quantity!);
    });

    return totalItemsAmmount;
  }

  List<CartModel> get getcartItems {
    return cartItems.entries.map((e) => e.value).toList();
  }

 List<CartModel> getCartData()  {
    setCart =  cartRepo.getCart();
    return storageItems;
  }

  set setCart(List<CartModel> list) {
    storageItems = list;
    for (int i = 0; i < list.length; i++) {
      var product = list[i].product;
      var productId = product?.id;
      if (productId != null) {
        _cartItems.putIfAbsent(productId, () => list[i]);
      }
    }
  }

  List<CartModel> getCartHistoryData() {
    // cartRepo.removeCart();
    // setHistoryCart=cartRepo.getHistoryCart();
    // print(storageHistoryItems);

    return cartRepo.getHistoryCart();
  }

  set setHistoryCart(List<CartModel> list) {
    storageItems = list;
    for (int i = 0; i < list.length; i++) {
      var product = list[i].product;
      var productId = product?.id;
      if (productId != null) {
        _cartHistoryItems.putIfAbsent(productId, () => list[i]);
      }
    }
  }

  void CheckOut() {
    cartRepo.getCart();
    cartRepo.addtoCartHistory(getcartItems);
    cartRepo.getHistoryCart();
    clearCart();
  }

  void clearCart() {
    _cartItems = {};
    cartRepo.removeCart(Constants.CARTLIST);
    update();
  }

  void clearCartHistory() {
    _cartHistoryItems = {};
    cartRepo.removeCart(Constants.CARTHISTORYLIST);
    update();
  }
}
