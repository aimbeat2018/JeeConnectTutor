class CompletedSessionsListResponseModel {
  String? instructorId;
  String? courseId;
  String? courseName;
  String? coursePrice;
  int? courseCount;

  CompletedSessionsListResponseModel(
      {this.instructorId,
        this.courseId,
        this.courseName,
        this.coursePrice,
        this.courseCount});

  CompletedSessionsListResponseModel.fromJson(Map<String, dynamic> json) {
    instructorId = json['instructor_id'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    coursePrice = json['course_price'];
    courseCount = json['course_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instructor_id'] = this.instructorId;
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['course_price'] = this.coursePrice;
    data['course_count'] = this.courseCount;
    return data;
  }
}
