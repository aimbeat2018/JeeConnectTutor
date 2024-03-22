class LectureTypeResponseModel {
  List<LectureMode>? lectureMode;

  LectureTypeResponseModel({this.lectureMode});

  LectureTypeResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['lecture_mode'] != null) {
      lectureMode = <LectureMode>[];
      json['lecture_mode'].forEach((v) {
        lectureMode!.add(new LectureMode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lectureMode != null) {
      data['lecture_mode'] = this.lectureMode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LectureMode {
  String? id;
  String? mode;

  LectureMode({this.id, this.mode});

  LectureMode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mode'] = this.mode;
    return data;
  }
}
