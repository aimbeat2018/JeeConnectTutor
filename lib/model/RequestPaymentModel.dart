class RequestPaymentModel {
  String? authToken;
  String? totalAmount;

  RequestPaymentModel({this.authToken, this.totalAmount});

  RequestPaymentModel.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth_token'] = this.authToken;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}
