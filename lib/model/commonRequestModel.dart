class CommonRequestModel {
  String? id;
  String? authToken;
  String? scheduleId;
  String? studentId;
  String? fromDate;
  String? toDate;
  String? otp;
  String? startTime;
  String? endTime;
  String? rating;
  String? review;

  CommonRequestModel(
      {this.id,
      this.authToken,
      this.fromDate,
      this.toDate,
      this.otp,
      this.startTime,
      this.scheduleId,
      this.studentId,
      this.endTime,
      this.rating,
      this.review});

  CommonRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authToken = json['auth_token'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    scheduleId = json['schedule_id'];
    studentId = json['student_id'];
    otp = json['otp'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    rating = json['rating'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['auth_token'] = authToken;
    data['from_date'] = fromDate;
    data['otp'] = otp;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['rating'] = rating;
    data['review'] = review;
    data['schedule_id'] = scheduleId;
    data['student_id'] = studentId;
    return data;
  }
}
