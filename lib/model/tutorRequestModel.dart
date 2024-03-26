class TutorRequestModel {
  String? status;
  List<Data>? data;

  TutorRequestModel({this.status, this.data});

  TutorRequestModel.fromJson(Map<String, dynamic> json) {
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
  String? packagePurchaseId;
  String? packageId;
  String? paymentId;
  String? courseName;
  String? boardName;
  String? gradeName;
  String? subjectName;
  String? studentName;
  String? noOfSession;
  String? noOfChapters;
  String? duration;
  String? price;
  String? modeOfTeaching;
  List<Chapterlist>? chapterlist;
  String? purchaseDate;
  List<Session>? session;

  Data(
      {this.packagePurchaseId,
        this.packageId,
        this.paymentId,
        this.courseName,
        this.boardName,
        this.gradeName,
        this.subjectName,
        this.studentName,
        this.noOfSession,
        this.noOfChapters,
        this.duration,
        this.price,
        this.modeOfTeaching,
        this.chapterlist,
        this.purchaseDate,
        this.session});

  Data.fromJson(Map<String, dynamic> json) {
    packagePurchaseId = json['package_purchase_id'];
    packageId = json['package_id'];
    paymentId = json['payment_id'];
    courseName = json['course_name'];
    boardName = json['board_name'];
    gradeName = json['grade_name'];
    subjectName = json['subject_name'];
    studentName = json['student_name'];
    noOfSession = json['no_of_session'];
    noOfChapters = json['no_of_chapters'];
    duration = json['duration'];
    price = json['price'];
    modeOfTeaching = json['mode_of_teaching'];
    if (json['chapterlist'] != null) {
      chapterlist = <Chapterlist>[];
      json['chapterlist'].forEach((v) {
        chapterlist!.add(new Chapterlist.fromJson(v));
      });
    }
    purchaseDate = json['purchase_date'];
    if (json['session'] != null) {
      session = <Session>[];
      json['session'].forEach((v) {
        session!.add(new Session.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_purchase_id'] = this.packagePurchaseId;
    data['package_id'] = this.packageId;
    data['payment_id'] = this.paymentId;
    data['course_name'] = this.courseName;
    data['board_name'] = this.boardName;
    data['grade_name'] = this.gradeName;
    data['subject_name'] = this.subjectName;
    data['student_name'] = this.studentName;
    data['no_of_session'] = this.noOfSession;
    data['no_of_chapters'] = this.noOfChapters;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['mode_of_teaching'] = this.modeOfTeaching;
    if (this.chapterlist != null) {
      data['chapterlist'] = this.chapterlist!.map((v) => v.toJson()).toList();
    }
    data['purchase_date'] = this.purchaseDate;
    if (this.session != null) {
      data['session'] = this.session!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapterlist {
  String? chapters;

  Chapterlist({this.chapters});

  Chapterlist.fromJson(Map<String, dynamic> json) {
    chapters = json['chapters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapters'] = this.chapters;
    return data;
  }
}

class Session {
  String? sessionId;
  String? day;
  String? time;
  String? date;
  String? subject;
  String? googleMeetLink;
  String? status;

  Session(
      {this.sessionId,
        this.day,
        this.time,
        this.date,
        this.subject,
        this.googleMeetLink,
        this.status});

  Session.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    day = json['day'];
    time = json['time'];
    date = json['date'];
    subject = json['subject'];
    googleMeetLink = json['google_meet_link'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    data['day'] = this.day;
    data['time'] = this.time;
    data['date'] = this.date;
    data['subject'] = this.subject;
    data['google_meet_link'] = this.googleMeetLink;
    data['status'] = this.status;
    return data;
  }
}
