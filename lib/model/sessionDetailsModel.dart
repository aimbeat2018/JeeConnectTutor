class SessionDetailsModel {
  String? status;
  List<Data>? data;

  SessionDetailsModel({this.status, this.data});

  SessionDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? sessionId;
  String? packageId;
  String? day;
  String? time;
  String? date;
  String? noOfChaoters;
  String? noOfComplete;
  String? subject;
  String? otpCode;
  String? googleMeetLink;
  String? status;
  String? studentName;
  String? studentAdd;
  String? sessionType;

  Data(
      {this.sessionId,
        this.packageId,
        this.day,
        this.time,
        this.date,
        this.noOfChaoters,
        this.noOfComplete,
        this.subject,
        this.otpCode,
        this.googleMeetLink,
        this.status,
        this.studentName,
        this.studentAdd,
        this.sessionType});

  Data.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    packageId = json['package_id'];
    day = json['day'];
    time = json['time'];
    date = json['date'];
    noOfChaoters = json['no_of_chaoters'];
    noOfComplete = json['no_of_complete'];
    subject = json['subject'];
    otpCode = json['otp_code'];
    googleMeetLink = json['google_meet_link'];
    status = json['status'];
    studentName = json['student_name'];
    studentAdd = json['student_add'];
    sessionType = json['session_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    data['package_id'] = this.packageId;
    data['day'] = this.day;
    data['time'] = this.time;
    data['date'] = this.date;
    data['no_of_chaoters'] = this.noOfChaoters;
    data['no_of_complete'] = this.noOfComplete;
    data['subject'] = this.subject;
    data['otp_code'] = this.otpCode;
    data['google_meet_link'] = this.googleMeetLink;
    data['status'] = this.status;
    data['student_name'] = this.studentName;
    data['student_add'] = this.studentAdd;
    data['session_type'] = this.sessionType;
    return data;
  }
}
