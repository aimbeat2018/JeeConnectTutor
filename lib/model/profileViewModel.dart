class ProfileViewModel {
  String? userId;
  String? name;
  String? email;
  String? phone;
  List<CourseInfo>? courseInfo;
  String? mode;
  String? experience;
  String? location;
  String? area;
  String? noc;
  String? adhaarNo;
  String? panNo;
  String? bankName;
  String? accountHolderName;
  String? accountNo;
  String? ifscCode;
  String? pincode;
  String? uniqueCode;

  ProfileViewModel(
      {this.userId,
      this.name,
      this.email,
      this.phone,
      this.courseInfo,
      this.mode,
      this.experience,
      this.location,
      this.area,
      this.noc,
      this.adhaarNo,
      this.panNo,
      this.bankName,
      this.accountHolderName,
      this.accountNo,
      this.ifscCode,
      this.uniqueCode,
      this.pincode});

  ProfileViewModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uniqueCode = json['unique_code'];
    if (json['course_info'] != null) {
      courseInfo = <CourseInfo>[];
      json['course_info'].forEach((v) {
        courseInfo!.add(new CourseInfo.fromJson(v));
      });
    }
    mode = json['mode'];
    experience = json['experience'];
    location = json['location'];
    area = json['area'];
    noc = json['noc'];
    adhaarNo = json['adhaar_no'];
    panNo = json['pan_no'];
    bankName = json['bank_name'];
    accountHolderName = json['account_holder_name'];
    accountNo = json['account_no'];
    ifscCode = json['ifsc_code'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['unique_code'] = this.uniqueCode;
    data['phone'] = this.phone;
    if (this.courseInfo != null) {
      data['course_info'] = this.courseInfo!.map((v) => v.toJson()).toList();
    }
    data['mode'] = this.mode;
    data['experience'] = this.experience;
    data['location'] = this.location;
    data['area'] = this.area;
    data['noc'] = this.noc;
    data['adhaar_no'] = this.adhaarNo;
    data['pan_no'] = this.panNo;
    data['bank_name'] = this.bankName;
    data['account_holder_name'] = this.accountHolderName;
    data['account_no'] = this.accountNo;
    data['ifsc_code'] = this.ifscCode;
    data['pincode'] = this.pincode;
    return data;
  }
}

class CourseInfo {
  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? subCategoryName;
  List<SelectedCourse>? selectedCourse;

  CourseInfo(
      {this.categoryId,
      this.categoryName,
      this.subCategoryId,
      this.subCategoryName,
      this.selectedCourse});

  CourseInfo.fromJson(Map<String, dynamic> json) {
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
  String? courseName;

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
