class RegisterData {
  bool? isAdmin;
  String? username;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? address3;
  String? poscode;
  String? city;
  String? state;
  int? age;
  String? phoneNumber;
  DateTime? dateOfBirth;
  String? profileImage;

  RegisterData({
    this.isAdmin = false,
    this.username,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.address3,
    this.poscode,
    this.city,
    this.state,
    this.age,
    this.phoneNumber,
    this.dateOfBirth,
    this.profileImage,
  });

  RegisterData.fromJson(Map<String, dynamic> json) {
    isAdmin = json['isAdmin'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    poscode = json['poscode'];
    city = json['city'];
    state = json['state'];
    age = json['age'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isAdmin'] = isAdmin;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['address1'] = address1;
    data['address2'] = address2;
    data['address3'] = address3;
    data['poscode'] = poscode;
    data['city'] = city;
    data['state'] = state;
    data['age'] = age;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['profile_image'] = profileImage;
    return data;
  }
}
