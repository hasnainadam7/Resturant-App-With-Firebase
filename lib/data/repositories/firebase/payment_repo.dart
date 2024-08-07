import 'dart:convert';


import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resturantapp/controller/cart_repo_controller.dart';
import 'package:resturantapp/controller/user_repo_controller.dart';
import 'package:resturantapp/models/response_model.dart';

import '../../../utils/constants.dart';


class PaymentRepo extends GetxService {
  Map<String, dynamic>? paymentIntent;

  Future<ResponseModel> makePayment() async {
    ResponseModel responseModel;

    try {
      // Create payment intent data
      print(    Get.find<CartRepoController>().getTotalAmmount.toString());
      paymentIntent = await createPaymentIntent(
          Get.find<CartRepoController>().getTotalAmmount.toString(), 'PKR');
      if (paymentIntent!["error"] is bool && paymentIntent!["error"]) {
        print(paymentIntent!["error"]);
      } else if (paymentIntent!["error"] is Map<String, dynamic>) {
        String cleanedMessage = paymentIntent!["error"]["message"].replaceAll('â¨', 'PKR ');
        return responseModel =
            ResponseModel(false, cleanedMessage);
      }
    } catch (e) {
      print("Error $e");
      return responseModel = ResponseModel(false, e.toString());
    }

    // Initialize the payment sheet setup
    var data = await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        customFlow: false,
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        customerEphemeralKeySecret: paymentIntent!["ephemeralKey"],
        customerId: paymentIntent!["id"],
        googlePay: const PaymentSheetGooglePay(
          testEnv: true,
          currencyCode: "PKR",
          merchantCountryCode: "PK",
        ),
        merchantDisplayName: 'Hasnain',
      ),
    );

    // Display payment sheet
    responseModel = await displayPaymentSheet();
    print(paymentIntent);
    print("Result is $paymentIntent");
    // } catch (e) {

    //   if (e is StripeConfigException) {
    //     print("Stripe exception: ${e.message}");
    //   } else {
    //     print("Exception: $e");
    //   }
    //   responseModel = ResponseModel(false, e.toString());
    // }

    return responseModel;
  }

  Future<ResponseModel> displayPaymentSheet() async {
    ResponseModel responseModel;
    try {
      var result = await Stripe.instance.presentPaymentSheet();

      responseModel = ResponseModel(true, "$result");
      paymentIntent = null;
    } on StripeException catch (e) {
      responseModel = ResponseModel(false, e.toString());
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
    }
    return responseModel;
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
        'receipt_email': Get.find<UserRepoController>().userModel.email,
      };
      var secretKey = Constants.STRIPE_SK;
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      final responseBody = jsonDecode(response.body);

      // Now you can access the `status` field.
      print('Payment Intent Body: $responseBody');
      return responseBody;
    } catch (err) {
      print('Error charging user: ${err.toString()}');
      return null;
    }
  }
}
