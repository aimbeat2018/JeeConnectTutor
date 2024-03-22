class GradeRequestModel {
  List<String>? gradeId;

  GradeRequestModel({this.gradeId});

  GradeRequestModel.fromJson(Map<String, dynamic> json) {
    gradeId = json['grade_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grade_id'] = this.gradeId;
    return data;
  }
}
