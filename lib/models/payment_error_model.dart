class PaymentErrorModel {
  Error? error;

  PaymentErrorModel({this.error});
  PaymentErrorModel.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }
}

class Error {
  String? code;
  String? docUrl;
  String? message;
  String? requestLogUrl;
  String? type;

  Error({this.code, this.docUrl, this.message, this.requestLogUrl, this.type});

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    docUrl = json['doc_url'];
    message = json['message'];
    requestLogUrl = json['request_log_url'];
    type = json['type'];
  }
}
