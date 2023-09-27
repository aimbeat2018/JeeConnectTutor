class CommonRequestModel {
  String? id;
  String? authToken;
  String? fromDate;
  String? toDate;
  String? otp;
  String? startTime;

  CommonRequestModel(
      {this.id,
      this.authToken,
      this.fromDate,
      this.toDate,
      this.otp,
      this.startTime});

  CommonRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authToken = json['auth_token'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    otp = json['otp'];
    startTime = json['start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['auth_token'] = this.authToken;
    data['from_date'] = this.fromDate;
    data['otp'] = this.otp;
    data['start_time'] = this.startTime;
    return data;
  }
}
