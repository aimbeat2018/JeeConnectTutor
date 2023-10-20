class TutorRequestModel {
  String? id;
  String? scheduleId;
  String? courseId;
  String? userId;
  String? day;
  String? shift;
  String? time;
  String? date;
  String? paymentId;
  String? instructorId;
  String? status;
  String? isScheduled;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;
  String? courseName;
  String? studentName;
  String? studentPhone;
  String? studentAddress;
  int? noOfSession;

  TutorRequestModel(
      {this.id,
      this.scheduleId,
      this.courseId,
      this.userId,
      this.day,
      this.shift,
      this.time,
      this.date,
      this.paymentId,
      this.instructorId,
      this.status,
      this.isScheduled,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.courseName,
      this.studentName,
      this.studentPhone,
      this.studentAddress,
      this.noOfSession});

  TutorRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['schedule_id'];
    courseId = json['course_id'];
    userId = json['user_id'];
    day = json['day'];
    shift = json['shift'];
    time = json['time'];
    date = json['date'];
    paymentId = json['payment_id'];
    instructorId = json['instructor_id'];
    status = json['status'];
    isScheduled = json['is_scheduled'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    courseName = json['course_name'];
    studentName = json['student_name'];
    studentPhone = json['student_phone'];
    studentAddress = json['student_address'];
    noOfSession = json['no_of_session'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['schedule_id'] = this.scheduleId;
    data['course_id'] = this.courseId;
    data['user_id'] = this.userId;
    data['day'] = this.day;
    data['shift'] = this.shift;
    data['time'] = this.time;
    data['date'] = this.date;
    data['payment_id'] = this.paymentId;
    data['instructor_id'] = this.instructorId;
    data['status'] = this.status;
    data['is_scheduled'] = this.isScheduled;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['course_name'] = this.courseName;
    data['student_name'] = this.studentName;
    data['student_phone'] = this.studentPhone;
    data['student_address'] = this.studentAddress;
    data['no_of_session'] = this.noOfSession;
    return data;
  }
}
