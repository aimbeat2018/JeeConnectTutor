class UpdateProfileModel {
  int? userId;
  List<CourseDetails>? courseDetails;
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
      this.courseDetails,
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
    if (json['course_details'] != null) {
      courseDetails = <CourseDetails>[];
      json['course_details'].forEach((v) {
        courseDetails!.add(new CourseDetails.fromJson(v));
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
    if (this.courseDetails != null) {
      data['course_details'] =
          this.courseDetails!.map((v) => v.toJson()).toList();
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

class CourseDetails {
  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? subCategoryName;
  List<SelectedCourse>? selectedCourse;

  CourseDetails(
      {this.categoryId,
      this.categoryName,
      this.subCategoryId,
      this.subCategoryName,
      this.selectedCourse});

  CourseDetails.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subCategoryId = json['sub_category_id'];
    subCategoryName = json['sub_category_name'];
    if (json['selected_course'] != null) {
      selectedCourse = <SelectedCourse>[];
      json['selected_course'].forEach((v) {
        selectedCourse!.add(new SelectedCourse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['sub_category_id'] = this.subCategoryId;
    data['sub_category_name'] = this.subCategoryName;
    if (this.selectedCourse != null) {
      data['selected_course'] =
          this.selectedCourse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelectedCourse {
  String? courseId;
  String? courseName = "";

  SelectedCourse({this.courseId, this.courseName});

  SelectedCourse.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    return data;
  }
}
