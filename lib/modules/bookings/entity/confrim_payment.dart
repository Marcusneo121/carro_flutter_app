class ConfirmPayment {
  Data? data;
  String? message;

  ConfirmPayment({this.data, this.message});

  ConfirmPayment.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? paymentReferenceId;

  Data({this.paymentReferenceId});

  Data.fromJson(Map<String, dynamic> json) {
    paymentReferenceId = json['payment_reference_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_reference_id'] = paymentReferenceId;
    return data;
  }
}
