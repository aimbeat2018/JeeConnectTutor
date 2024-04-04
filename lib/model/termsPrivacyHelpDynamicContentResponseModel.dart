class TermsPrivacyHelpDynamicContentResponseModel {
  String? status;
  String? contactEmail;
  String? aboutUs;
  String? privacyPolicy;
  String? termsCondition;
  String? facebook;
  String? linkedin;
  String? instragram;
  String? youtube;
  String? whatsap;
  String? phone;
  String? address;

  TermsPrivacyHelpDynamicContentResponseModel(
      {this.status,
        this.contactEmail,
        this.aboutUs,
        this.privacyPolicy,
        this.termsCondition,
        this.facebook,
        this.linkedin,
        this.instragram,
        this.youtube,
        this.whatsap,
        this.phone,
        this.address});

  TermsPrivacyHelpDynamicContentResponseModel.fromJson(
      Map<String, dynamic> json) {
    status = json['status'];
    contactEmail = json['contact_email'];
    aboutUs = json['about_us'];
    privacyPolicy = json['privacy_policy'];
    termsCondition = json['terms_condition'];
    facebook = json['facebook'];
    linkedin = json['linkedin'];
    instragram = json['instragram'];
    youtube = json['youtube'];
    whatsap = json['whatsap'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['contact_email'] = this.contactEmail;
    data['about_us'] = this.aboutUs;
    data['privacy_policy'] = this.privacyPolicy;
    data['terms_condition'] = this.termsCondition;
    data['facebook'] = this.facebook;
    data['linkedin'] = this.linkedin;
    data['instragram'] = this.instragram;
    data['youtube'] = this.youtube;
    data['whatsap'] = this.whatsap;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
