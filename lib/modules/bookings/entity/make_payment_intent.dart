class MakePaymentIntent {
  Data? data;
  String? message;

  MakePaymentIntent({this.data, this.message});

  MakePaymentIntent.fromJson(Map<String, dynamic> json) {
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
  String? paymentIntent;
  String? ephemeralKey;
  String? customer;
  String? publishableKey;
  int? paymentTransactionId;

  Data({
    this.paymentIntent,
    this.ephemeralKey,
    this.customer,
    this.publishableKey,
    this.paymentTransactionId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    paymentIntent = json['paymentIntent'];
    ephemeralKey = json['ephemeralKey'];
    customer = json['customer'];
    publishableKey = json['publishableKey'];
    paymentTransactionId = json['payment_transaction_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentIntent'] = paymentIntent;
    data['ephemeralKey'] = ephemeralKey;
    data['customer'] = customer;
    data['publishableKey'] = publishableKey;
    data['payment_transaction_id'] = paymentTransactionId;
    return data;
  }
}
