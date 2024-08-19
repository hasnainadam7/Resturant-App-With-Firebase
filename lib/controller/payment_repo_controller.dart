import 'package:get/get.dart';

import '../data/repositories/payment_repo.dart';
import '../models/response_model.dart';

class PaymentRepoController extends GetxController{



  PaymentRepo paymentRepo ;
  PaymentRepoController({required this.paymentRepo});

  Future<ResponseModel> makePayment() async {
  return paymentRepo.makePayment();

  }
}