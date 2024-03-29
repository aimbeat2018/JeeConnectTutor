class CompletedSessionsListResponseModel {
  String? status;
  List<Walletdetails>? walletdetails;
  List<Data>? data;

  CompletedSessionsListResponseModel(
      {this.status, this.walletdetails, this.data});

  CompletedSessionsListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['walletdetails'] != null) {
      walletdetails = <Walletdetails>[];
      json['walletdetails'].forEach((v) {
        walletdetails!.add(new Walletdetails.fromJson(v));
      });
    }
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
    if (this.walletdetails != null) {
      data['walletdetails'] =
          this.walletdetails!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Walletdetails {
  String? wallet;
  String? useWallet;
  String? pendingWallet;

  Walletdetails({this.wallet, this.useWallet, this.pendingWallet});

  Walletdetails.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    useWallet = json['use_wallet'];
    pendingWallet = json['pending_wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet'] = this.wallet;
    data['use_wallet'] = this.useWallet;
    data['pending_wallet'] = this.pendingWallet;
    return data;
  }
}

class Data {
  String? sessionId;
  String? day;
  String? time;
  String? date;
  String? otpCode;
  String? subject;
  String? googleMeetLink;
  String? status;
  String? instructorName;
  String? startTime;
  String? endTime;
  String? studRivew;
  String? insReview;

  Data(
      {this.sessionId,
        this.day,
        this.time,
        this.date,
        this.otpCode,
        this.subject,
        this.googleMeetLink,
        this.status,
        this.instructorName,
        this.startTime,
        this.endTime,
        this.studRivew,
        this.insReview});

  Data.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    day = json['day'];
    time = json['time'];
    date = json['date'];
    otpCode = json['otp_code'];
    subject = json['subject'];
    googleMeetLink = json['google_meet_link'];
    status = json['status'];
    instructorName = json['instructor_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    studRivew = json['stud_rivew'];
    insReview = json['ins_review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    data['day'] = this.day;
    data['time'] = this.time;
    data['date'] = this.date;
    data['otp_code'] = this.otpCode;
    data['subject'] = this.subject;
    data['google_meet_link'] = this.googleMeetLink;
    data['status'] = this.status;
    data['instructor_name'] = this.instructorName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['stud_rivew'] = this.studRivew;
    data['ins_review'] = this.insReview;
    return data;
  }
}