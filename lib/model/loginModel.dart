class LoginModel {
  String? userId;
  String? name;
  String? parentName;
  String? phone;
  String? uniqueCode;
  String? role;
  String? profileUpdated;
  int? validity;
  String? token;

  LoginModel(
      {this.userId,
      this.name,
      this.parentName,
      this.phone,
      this.profileUpdated,
      this.uniqueCode,
      this.role,
      this.validity,
      this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    parentName = json['parent_name'];
    phone = json['phone'];
    profileUpdated = json['profile_updated'];
    uniqueCode = json['unique_code'];
    role = json['role'];
    validity = json['validity'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userId;
    data['name'] = name;
    data['parent_name'] = parentName;
    data['profile_updated'] = profileUpdated;
    data['phone'] = phone;
    data['unique_code'] = uniqueCode;
    data['role'] = role;
    data['validity'] = validity;
    data['token'] = token;
    return data;
  }
}
