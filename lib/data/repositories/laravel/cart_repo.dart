import 'dart:convert';

import 'package:resturantapp/models/cart_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';



class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cartList = [];
  List<String> cartHistoryList = [];

  List<CartModel> getCart()  {
    List<CartModel> cartModels = [];
    List<String> cartStrings = [];
    if (sharedPreferences.containsKey(Constants.CARTLIST)) {
      cartStrings = sharedPreferences.getStringList(Constants.CARTLIST)!;
    }
    for (var val in cartStrings) {
      cartModels.add(CartModel.fromJson(jsonDecode(val)));
    }
    return cartModels;
  }

  List<CartModel> getHistoryCart()  {
    List<CartModel> cartHistoryModels = [];
    List<String> cartHistoryStrings = [];
    if (sharedPreferences.containsKey(Constants.CARTHISTORYLIST)) {
      cartHistoryStrings =
           sharedPreferences.getStringList(Constants.CARTHISTORYLIST)!;
    }
    for (var val in cartHistoryStrings) {
      cartHistoryModels.add(CartModel.fromJson(jsonDecode(val)));
    }
    return cartHistoryModels;
  }

  void addToCartList(List<CartModel> cart) {
    String time = DateTime.now().toString();
    cartList = [];
    for (var val in cart) {
      val.time = time;
      cartList.add(jsonEncode(val));
    }
    sharedPreferences.setStringList(Constants.CARTLIST, cartList);
  }

  // void cartItemsPerOrder() {
  //   List<CartModel> updatedHistory = getHistoryCart();
  //
  //   Map<String, int> cartHistoryItemsPerOrder = {};
  //
  //   // Count the number of items per order
  //   for (int i = 0; i < updatedHistory.length; i++) {
  //     String orderTime = updatedHistory[i].time!;
  //     if (cartHistoryItemsPerOrder.containsKey(orderTime)) {
  //       cartHistoryItemsPerOrder.update(orderTime, (val) => val + 1);
  //     } else {
  //       cartHistoryItemsPerOrder.putIfAbsent(orderTime, () => 1);
  //     }
  //   }
  //
  //   // List to store the count of items per order
  //   List<int> orderTimes = cartHistoryItemsPerOrder.entries.map((val) => val.value).toList();
  //
  //   // Print the items in each order
  //   // int incCounter = 0;
  //   // // for (int i = 0; i < orderTimes.length; i++) {
  //   // //   print("\n");
  //   // //   for (int j = 0; j < orderTimes[i]; j++) {
  //   // //     print(updatedHistory[incCounter++].product.toString());
  //   // //   }
  //   // //
  //   // // }
  // }

  void addtoCartHistory(List<CartModel> newCartList) {
    // Fetch the current cart history from SharedPreferences
    List<CartModel> currentHistory = getHistoryCart();
    Map<String, int> cartHistoryItemsPerOrder = {};
    for (var item in currentHistory) {
      String orderTime = item.time ?? ''; // Ensure time is not null
      if (cartHistoryItemsPerOrder.containsKey(orderTime)) {
        cartHistoryItemsPerOrder.update(orderTime, (val) => val + 1);
      } else {
        cartHistoryItemsPerOrder.putIfAbsent(orderTime, () => 1);
      }
    }
    // Add the new items to the current history
    cartHistoryList = currentHistory.map((item) => jsonEncode(item)).toList();
    cartHistoryList
        .addAll(newCartList.map((item) => jsonEncode(item)).toList());

    // Save the updated history back to SharedPreferences
    sharedPreferences.setStringList(Constants.CARTHISTORYLIST, cartHistoryList);

    // Clear the current cart


    // Print the updated cart history for debugging
    // List<CartModel> updatedHistory = getHistoryCart();
  }

  void removeCart(String name) {
    // sharedPreferences.remove(Constants.CARTHISTORYLIST);
    sharedPreferences.remove(name);
  }
}
