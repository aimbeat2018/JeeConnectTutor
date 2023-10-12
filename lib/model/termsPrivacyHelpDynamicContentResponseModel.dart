class TermsPrivacyHelpDynamicContentResponseModel {
  String? privacyPolicy;
  String? termsCondition;
  String? email;
  String? phone;
  String? address;

  TermsPrivacyHelpDynamicContentResponseModel(
      {this.privacyPolicy,
        this.termsCondition,
        this.email,
        this.phone,
        this.address});

  TermsPrivacyHelpDynamicContentResponseModel.fromJson(
      Map<String, dynamic> json) {
    privacyPolicy = json['privacy_policy'];
    termsCondition = json['terms_condition'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['privacy_policy'] = this.privacyPolicy;
    data['terms_condition'] = this.termsCondition;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
