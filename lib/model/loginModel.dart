class LoginModel {
  String? status;
  String? userId;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? email;
  List<Pincode>? pincode;
  String? address;
  String? uniqueCode;
  String? role;
  String? boardId;
  String? boardName;
  List<TechingDetails>? techingDetails;
  List<GradeDetails>? gradeDetails;
  List<SubjectDetails>? subjectDetails;
  String? aadharNo;
  String? panNo;
  String? bankName;
  String? accountHolderName;
  String? accountNo;
  String? ifscCode;
  String? msg;

  LoginModel(
      {this.status,
        this.userId,
        this.firstName,
        this.lastName,
        this.mobileNo,
        this.email,
        this.pincode,
        this.address,
        this.uniqueCode,
        this.role,
        this.boardId,
        this.boardName,
        this.techingDetails,
        this.gradeDetails,
        this.subjectDetails,
        this.aadharNo,
        this.panNo,
        this.bankName,
        this.accountHolderName,
        this.accountNo,
        this.ifscCode,
        this.msg});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    if (json['pincode'] != null) {
      pincode = <Pincode>[];
      json['pincode'].forEach((v) {
        pincode!.add(new Pincode.fromJson(v));
      });
    }
    address = json['address'];
    uniqueCode = json['unique_code'];
    role = json['role'];
    boardId = json['board_id'];
    boardName = json['board_name'];
    if (json['teching_details'] != null) {
      techingDetails = <TechingDetails>[];
      json['teching_details'].forEach((v) {
        techingDetails!.add(new TechingDetails.fromJson(v));
      });
    }
    if (json['grade_details'] != null) {
      gradeDetails = <GradeDetails>[];
      json['grade_details'].forEach((v) {
        gradeDetails!.add(new GradeDetails.fromJson(v));
      });
    }
    if (json['subject_details'] != null) {
      subjectDetails = <SubjectDetails>[];
      json['subject_details'].forEach((v) {
        subjectDetails!.add(new SubjectDetails.fromJson(v));
      });
    }
    aadharNo = json['aadhar_no'];
    panNo = json['pan_no'];
    bankName = json['bank_name'];
    accountHolderName = json['account_holder_name'];
    accountNo = json['account_no'];
    ifscCode = json['ifsc_code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    if (this.pincode != null) {
      data['pincode'] = this.pincode!.map((v) => v.toJson()).toList();
    }
    data['address'] = this.address;
    data['unique_code'] = this.uniqueCode;
    data['role'] = this.role;
    data['board_id'] = this.boardId;
    data['board_name'] = this.boardName;
    if (this.techingDetails != null) {
      data['teching_details'] =
          this.techingDetails!.map((v) => v.toJson()).toList();
    }
    if (this.gradeDetails != null) {
      data['grade_details'] =
          this.gradeDetails!.map((v) => v.toJson()).toList();
    }
    if (this.subjectDetails != null) {
      data['subject_details'] =
          this.subjectDetails!.map((v) => v.toJson()).toList();
    }
    data['aadhar_no'] = this.aadharNo;
    data['pan_no'] = this.panNo;
    data['bank_name'] = this.bankName;
    data['account_holder_name'] = this.accountHolderName;
    data['account_no'] = this.accountNo;
    data['ifsc_code'] = this.ifscCode;
    data['msg'] = this.msg;
    return data;
  }
}

class Pincode {
  String? pincode;

  Pincode({this.pincode});

  Pincode.fromJson(Map<String, dynamic> json) {
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pincode'] = this.pincode;
    return data;
  }
}

class TechingDetails {
  String? modeOfTeching;

  TechingDetails({this.modeOfTeching});

  TechingDetails.fromJson(Map<String, dynamic> json) {
    modeOfTeching = json['mode_of_teching'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode_of_teching'] = this.modeOfTeching;
    return data;
  }
}

class GradeDetails {
  String? gradeId;
  String? gradeName;

  GradeDetails({this.gradeId, this.gradeName});

  GradeDetails.fromJson(Map<String, dynamic> json) {
    gradeId = json['grade_id'];
    gradeName = json['grade_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grade_id'] = this.gradeId;
    data['grade_name'] = this.gradeName;
    return data;
  }
}

class SubjectDetails {
  String? subjectId;
  String? subjectName;

  SubjectDetails({this.subjectId, this.subjectName});

  SubjectDetails.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_id'] = this.subjectId;
    data['subject_name'] = this.subjectName;
    return data;
  }
}
