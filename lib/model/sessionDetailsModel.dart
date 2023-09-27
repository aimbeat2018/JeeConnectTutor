class SessionDetailsModel {
  String? id;
  String? scheduleId;
  String? courseId;
  String? userId;
  String? day;
  String? shift;
  String? time;
  String? date;
  String? paymentId;
  String? status;
  String? instructorId;
  String? otpCode;
  String? startTime;
  String? endTime;
  String? studReviewStatus;
  String? studRivew;
  String? insReviewStatus;
  String? insReview;
  String? studRating;
  String? insRating;
  String? isScheduled;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;
  String? courseName;
  String? studentName;
  String? studentPhone;
  String? studentAddress;
  String? instructorName;
  String? instructorMobile;
  Null? instructorLocation;

  SessionDetailsModel(
      {this.id,
      this.scheduleId,
      this.courseId,
      this.userId,
      this.day,
      this.shift,
      this.time,
      this.date,
      this.paymentId,
      this.status,
      this.instructorId,
      this.otpCode,
      this.startTime,
      this.endTime,
      this.studReviewStatus,
      this.studRivew,
      this.insReviewStatus,
      this.insReview,
      this.studRating,
      this.insRating,
      this.isScheduled,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.courseName,
      this.studentName,
      this.studentPhone,
      this.studentAddress,
      this.instructorName,
      this.instructorMobile,
      this.instructorLocation});

  SessionDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['schedule_id'];
    courseId = json['course_id'];
    userId = json['user_id'];
    day = json['day'];
    shift = json['shift'];
    time = json['time'];
    date = json['date'];
    paymentId = json['payment_id'];
    status = json['status'];
    instructorId = json['instructor_id'];
    otpCode = json['otp_code'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    studReviewStatus = json['stud_review_status'];
    studRivew = json['stud_rivew'];
    insReviewStatus = json['ins_review_status'];
    insReview = json['ins_review'];
    studRating = json['stud_rating'];
    insRating = json['ins_rating'];
    isScheduled = json['is_scheduled'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    courseName = json['course_name'];
    studentName = json['student_name'];
    studentPhone = json['student_phone'];
    studentAddress = json['student_address'];
    instructorName = json['instructor_name'];
    instructorMobile = json['instructor_mobile'];
    instructorLocation = json['instructor_location'];
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
    data['status'] = this.status;
    data['instructor_id'] = this.instructorId;
    data['otp_code'] = this.otpCode;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['stud_review_status'] = this.studReviewStatus;
    data['stud_rivew'] = this.studRivew;
    data['ins_review_status'] = this.insReviewStatus;
    data['ins_review'] = this.insReview;
    data['stud_rating'] = this.studRating;
    data['ins_rating'] = this.insRating;
    data['is_scheduled'] = this.isScheduled;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['course_name'] = this.courseName;
    data['student_name'] = this.studentName;
    data['student_phone'] = this.studentPhone;
    data['student_address'] = this.studentAddress;
    data['instructor_name'] = this.instructorName;
    data['instructor_mobile'] = this.instructorMobile;
    data['instructor_location'] = this.instructorLocation;
    return data;
  }
}
