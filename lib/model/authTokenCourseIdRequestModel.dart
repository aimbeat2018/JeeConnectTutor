class AuthTokenCourseIdRequestModel {
  String? authToken;
  String? courseId;

  AuthTokenCourseIdRequestModel({this.authToken, this.courseId});

  AuthTokenCourseIdRequestModel.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
    courseId = json['course_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth_token'] = this.authToken;
    data['course_id'] = this.courseId;
    return data;
  }
}
