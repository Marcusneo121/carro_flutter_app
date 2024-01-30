class LogoutResponse {
  bool? revoked;
  String? message;

  LogoutResponse({this.revoked, this.message});

  LogoutResponse.fromJson(Map<String, dynamic> json) {
    revoked = json['revoked'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['revoked'] = revoked;
    data['message'] = message;
    return data;
  }
}
