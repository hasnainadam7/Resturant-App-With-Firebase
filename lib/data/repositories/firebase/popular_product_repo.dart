// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:resturantapp/data/api/apiClient.dart';
import 'package:resturantapp/utils/constants.dart';




class PopularProductRepo extends GetxService  {
  final ApiClient apiClient;
  final String Endpoint = Constants.POPULAR_PRODUCT_API;
  PopularProductRepo({required this.apiClient});

  Future<Response> getProductListRepo() async {
    return await apiClient.getData(Endpoint);
  }
}
