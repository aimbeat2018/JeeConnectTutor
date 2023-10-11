class CommonResponseModel {
  String? message;
  int? status;
  bool? validity;

  CommonResponseModel({this.message, this.status, this.validity});

  CommonResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    validity = json['validity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['validity'] = this.validity;
    return data;
  }
}
