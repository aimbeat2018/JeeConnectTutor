class BoardsModel {
  String? status;
  List<Data>? data;

  BoardsModel({this.status, this.data});

  BoardsModel.fromJson(Map<String, dynamic> json) {
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
  String? boardId;
  String? boardName;
  String? courseId;
  String? courseName;

  Data({this.boardId, this.boardName, this.courseId, this.courseName});

  Data.fromJson(Map<String, dynamic> json) {
    boardId = json['board_id'];
    boardName = json['board_name'];
    courseId = json['course_id'];
    courseName = json['course_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['board_id'] = this.boardId;
    data['board_name'] = this.boardName;
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    return data;
  }
}
