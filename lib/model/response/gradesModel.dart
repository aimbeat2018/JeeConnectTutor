class GradesModel {
  String? status;
  List<Data>? data;

  GradesModel({this.status, this.data});

  GradesModel.fromJson(Map<String, dynamic> json) {
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
  String? gradeId;
  String? gradeName;
  String? courseId;
  String? courseName;
  String? boardId;
  String? boardName;

  Data(
      {this.gradeId,
        this.gradeName,
        this.courseId,
        this.courseName,
        this.boardId,
        this.boardName});

  Data.fromJson(Map<String, dynamic> json) {
    gradeId = json['grade_id'];
    gradeName = json['grade_name'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    boardId = json['board_id'];
    boardName = json['board_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grade_id'] = this.gradeId;
    data['grade_name'] = this.gradeName;
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['board_id'] = this.boardId;
    data['board_name'] = this.boardName;
    return data;
  }
}
