class UserSession {
  Data? data;
  Token? token;

  UserSession({this.data, this.token});

  UserSession.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (token != null) {
      data['token'] = token!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  Profile? profile;

  Data({this.user, this.profile});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? roleId;
  String? username;
  String? email;
  String? rememberMeToken;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.roleId,
      this.username,
      this.email,
      this.rememberMeToken,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    username = json['username'];
    email = json['email'];
    rememberMeToken = json['remember_me_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role_id'] = roleId;
    data['username'] = username;
    data['email'] = email;
    data['remember_me_token'] = rememberMeToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Profile {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? address3;
  String? age;
  String? phoneNumber;
  String? dateOfBirth;
  String? profileImage;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.address3,
      this.age,
      this.phoneNumber,
      this.dateOfBirth,
      this.profileImage,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    age = json['age'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    profileImage = json['profile_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['address1'] = address1;
    data['address2'] = address2;
    data['address3'] = address3;
    data['age'] = age;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['profile_image'] = profileImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Token {
  String? type;
  String? token;
  String? expiresAt;

  Token({this.type, this.token, this.expiresAt});

  Token.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    token = json['token'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['token'] = token;
    data['expires_at'] = expiresAt;
    return data;
  }
}
