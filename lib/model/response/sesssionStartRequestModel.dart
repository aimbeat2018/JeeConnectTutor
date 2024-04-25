class SesssionStartRequestModel {
  String? sessionId;
  String? otp;
  String? startTime;
  Meet? meet;

  SesssionStartRequestModel(
      {this.sessionId, this.otp, this.startTime, this.meet});

  SesssionStartRequestModel.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    otp = json['otp'];
    startTime = json['start_time'];
    meet = json['meet'] != null ? new Meet.fromJson(json['meet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    data['otp'] = this.otp;
    data['start_time'] = this.startTime;
    if (this.meet != null) {
      data['meet'] = this.meet!.toJson();
    }
    return data;
  }
}

class Meet {
  String? agenda;
  bool? defaultPassword;
  String? duration;
  String? password;
  Settings? settings;
  String? startTime;
  String? timezone;
  int? type;

  Meet(
      {this.agenda,
        this.defaultPassword,
        this.duration,
        this.password,
        this.settings,
        this.startTime,
        this.timezone,
        this.type});

  Meet.fromJson(Map<String, dynamic> json) {
    agenda = json['agenda'];
    defaultPassword = json['default_password'];
    duration = json['duration'];
    password = json['password'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    startTime = json['start_time'];
    timezone = json['timezone'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agenda'] = this.agenda;
    data['default_password'] = this.defaultPassword;
    data['duration'] = this.duration;
    data['password'] = this.password;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    data['start_time'] = this.startTime;
    data['timezone'] = this.timezone;
    data['type'] = this.type;
    return data;
  }
}

class Settings {
  String? audio;
  int? calendarType;
  String? contactEmail;
  String? contactName;
  bool? hostVideo;
  bool? muteUponEntry;
  bool? joinBeforeHost;

  Settings(
      {this.audio,
        this.calendarType,
        this.contactEmail,
        this.contactName,
        this.hostVideo,
        this.muteUponEntry,
        this.joinBeforeHost});

  Settings.fromJson(Map<String, dynamic> json) {
    audio = json['audio'];
    calendarType = json['calendar_type'];
    contactEmail = json['contact_email'];
    contactName = json['contact_name'];
    hostVideo = json['host_video'];
    muteUponEntry = json['mute_upon_entry'];
    joinBeforeHost = json['join_before_host'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audio'] = this.audio;
    data['calendar_type'] = this.calendarType;
    data['contact_email'] = this.contactEmail;
    data['contact_name'] = this.contactName;
    data['host_video'] = this.hostVideo;
    data['mute_upon_entry'] = this.muteUponEntry;
    data['join_before_host'] = this.joinBeforeHost;
    return data;
  }
}
