class RegisterModel {
  String? message;
  int? status;
  bool? validity;
  UserData? data;

  RegisterModel({this.message, this.status, this.validity, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    validity = json['validity'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['validity'] = validity;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? pincode;
  String? uniqueCode;
  int? isInstructor;
  int? status;
  int? profileUpdated;
  int? userId;

  UserData(
      {this.name,
      this.email,
      this.phone,
      this.password,
      this.pincode,
      this.uniqueCode,
      this.isInstructor,
      this.status,
      this.profileUpdated,
      this.userId});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    pincode = json['pincode'];
    uniqueCode = json['unique_code'];
    isInstructor = json['is_instructor'];
    status = json['status'];
    profileUpdated = json['profile_updated'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['pincode'] = pincode;
    data['unique_code'] = uniqueCode;
    data['is_instructor'] = isInstructor;
    data['status'] = status;
    data['profile_updated'] = profileUpdated;
    data['user_id'] = userId;
    return data;
  }
}
