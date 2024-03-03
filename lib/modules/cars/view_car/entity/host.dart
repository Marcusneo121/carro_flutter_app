class Host {
  Data? data;
  String? message;

  Host({this.data, this.message});

  Host.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? address3;
  String? phoneNumber;
  String? profileImage;
  String? poscode;
  String? city;
  String? state;

  Data(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.address3,
      this.phoneNumber,
      this.profileImage,
      this.poscode,
      this.city,
      this.state});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    phoneNumber = json['phone_number'];
    profileImage = json['profile_image'];
    poscode = json['poscode'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['phone_number'] = this.phoneNumber;
    data['profile_image'] = this.profileImage;
    data['poscode'] = this.poscode;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}