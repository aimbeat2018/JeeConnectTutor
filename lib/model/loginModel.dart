class LoginModel {
  String? userId;
  String? name;
  String? parentName;
  String? phone;
  String? uniqueCode;
  String? role;
  String? profileUpdated;
  String? referral_code;
  String? referral_stud;
  String? image;
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
      this.referral_code,
      this.referral_stud,
      this.image,
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
    referral_code = json['referral_code'];
    referral_stud = json['referral_stud'];
    image = json['image'];
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
    data['referral_code'] = referral_code;
    data['referral_stud'] = referral_stud;
    data['image'] = image;
    data['token'] = token;
    return data;
  }
}
