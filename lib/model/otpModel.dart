class OtpModel {
  int? otp;
  String? message;
  int? status;
  bool? validity;

  OtpModel({this.otp, this.message, this.status, this.validity});

  OtpModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    message = json['message'];
    status = json['status'];
    validity = json['validity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['message'] = this.message;
    data['status'] = this.status;
    data['validity'] = this.validity;
    return data;
  }
}
