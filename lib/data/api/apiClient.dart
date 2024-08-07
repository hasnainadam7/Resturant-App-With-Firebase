import 'dart:convert';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;

  //Server Url
  final String appBaseUrl;
  late Map<String, String> _header;
  String basicAuth = 'Basic ${base64Encode(utf8.encode('admin:admin'))}';

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = Constants.TOKEN;
    _header = {
      "Content-type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token",
    };
  }

          void updateToken(String newToken) {
        token = newToken;

        _header = {
          "Content-type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        };
      }

      Future<Response> getData(String uri) async {

          Response response = await get(uri, headers: _header);
          // print("The Data is :${response.body}");
          if (response.statusCode == 200) {

            return response;
          } else {
            return const Response(statusCode: 1, statusText: "HTTP error");
          }

      }

      Future<Response> postData(String uri, dynamic body) async {
          print("The URI IS "+uri);
          Response response = await post(uri, body,
              headers:
              _header); // Ensure 'body' and 'headers' are correctly specified
          return response;
        }

}
