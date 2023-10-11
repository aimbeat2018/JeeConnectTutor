class CompletedSessionDetailByIdResponseModel {
  String? id;
  String? day;
  String? time;
  String? date;
  String? startTime;
  String? endTime;
  String? studentName;
  String? courseName;

  CompletedSessionDetailByIdResponseModel(
      {this.id,
        this.day,
        this.time,
        this.date,
        this.startTime,
        this.endTime,
        this.studentName,
        this.courseName});

  CompletedSessionDetailByIdResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    time = json['time'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    studentName = json['student_name'];
    courseName = json['course_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['time'] = this.time;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['student_name'] = this.studentName;
    data['course_name'] = this.courseName;
    return data;
  }
}
