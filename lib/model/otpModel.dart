class OtpModel {
  String? otp;
  String? message;
  String? status;

  OtpModel({this.otp, this.message, this.status});

  OtpModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    message = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['msg'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
