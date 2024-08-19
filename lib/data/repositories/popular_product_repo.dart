// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:resturantapp/data/api/apiClient.dart';
import 'package:resturantapp/models/product_models.dart';
import 'package:resturantapp/utils/constants.dart';




class PopularProductRepo extends GetxService  {
  final ApiClient apiClient;
  final String Endpoint = Constants.POPULAR_PRODUCT_API;
  PopularProductRepo({required this.apiClient});

  Future<List<ProductsModel>> getProductListRepo(String category) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('product_type', isEqualTo: category) // Replace 'fieldName' and 'value' with your field name and the value you're checking for
        .get();
    List<ProductsModel> allData = querySnapshot.docs.map((doc) => ProductsModel.fromJson(doc.data() as Map<String, dynamic>)).toList();

    return allData;
  }
}
