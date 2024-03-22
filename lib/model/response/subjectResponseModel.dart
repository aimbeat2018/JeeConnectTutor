class SubjectResponseModel {
  String? status;
  List<Data>? data;

  SubjectResponseModel({this.status, this.data});

  SubjectResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? subjectId;
  String? subjectName;
  String? gradeId;
  String? gradeName;

  Data({this.subjectId, this.subjectName, this.gradeId, this.gradeName});

  Data.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    gradeId = json['grade_id'];
    gradeName = json['grade_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_id'] = this.subjectId;
    data['subject_name'] = this.subjectName;
    data['grade_id'] = this.gradeId;
    data['grade_name'] = this.gradeName;
    return data;
  }
}
