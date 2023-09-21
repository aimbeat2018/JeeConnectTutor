class UpdateCourseModel {
  String? courseId;
  String? courseName;
  int? charge;

  UpdateCourseModel({this.courseId, this.courseName, this.charge});

  UpdateCourseModel.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    charge = json['charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['charge'] = this.charge;
    return data;
  }
}
