class UpdateProfileModel {
  int? userId;
  List<ProfileCourse>? course;
  String? mode;
  int? experience;
  String? tutorLocation;
  String? area;
  String? noc;
  String? adhaarCard;
  String? panNo;
  String? bankName;
  String? accountHolderName;
  String? accountNo;
  String? ifscCode;

  UpdateProfileModel(
      {this.userId,
      this.course,
      this.mode,
      this.experience,
      this.tutorLocation,
      this.area,
      this.noc,
      this.adhaarCard,
      this.panNo,
      this.bankName,
      this.accountHolderName,
      this.accountNo,
      this.ifscCode});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    if (json['course'] != null) {
      course = <ProfileCourse>[];
      json['course'].forEach((v) {
        course!.add(new ProfileCourse.fromJson(v));
      });
    }
    mode = json['mode'];
    experience = json['experience'];
    tutorLocation = json['tutor_location'];
    area = json['area'];
    noc = json['noc'];
    adhaarCard = json['adhaar_card'];
    panNo = json['pan_no'];
    bankName = json['bank_name'];
    accountHolderName = json['account_holder_name'];
    accountNo = json['account_no'];
    ifscCode = json['ifsc_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    if (this.course != null) {
      data['course'] = this.course!.map((v) => v.toJson()).toList();
    }
    data['mode'] = this.mode;
    data['experience'] = this.experience;
    data['tutor_location'] = this.tutorLocation;
    data['area'] = this.area;
    data['noc'] = this.noc;
    data['adhaar_card'] = this.adhaarCard;
    data['pan_no'] = this.panNo;
    data['bank_name'] = this.bankName;
    data['account_holder_name'] = this.accountHolderName;
    data['account_no'] = this.accountNo;
    data['ifsc_code'] = this.ifscCode;
    return data;
  }
}

class ProfileCourse {
  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? subCategoryName;
  String? courseId;
  String? courseName;
  int? charge;

  ProfileCourse(
      {this.categoryId,
      this.categoryName,
      this.subCategoryId,
      this.subCategoryName,
      this.courseId,
      this.courseName,
      this.charge});

  ProfileCourse.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subCategoryId = json['sub_category_id'];
    subCategoryName = json['sub_category_name'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    charge = json['charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['sub_category_id'] = this.subCategoryId;
    data['sub_category_name'] = this.subCategoryName;
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['charge'] = this.charge;
    return data;
  }
}
