// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:resturantapp/data/api/apiClient.dart';
import 'package:resturantapp/utils/constants.dart';


class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  final String Endpoint =Constants.RECOMMENDED_PRODUCT_API;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getProductListRepo()async{

    return await apiClient.getData(Endpoint);
  }
}