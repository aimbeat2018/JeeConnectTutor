class SessionResponseModel {
  String? status;
  int? meetingId;
  String? startUrl;
  String? joinUrl;
  String? password;
  String? msg;

  SessionResponseModel(
      {this.status,
        this.meetingId,
        this.startUrl,
        this.joinUrl,
        this.password,
        this.msg});

  SessionResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    meetingId = json['meeting_id'];
    startUrl = json['start_url'];
    joinUrl = json['join_url'];
    password = json['password'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['meeting_id'] = this.meetingId;
    data['start_url'] = this.startUrl;
    data['join_url'] = this.joinUrl;
    data['password'] = this.password;
    data['msg'] = this.msg;
    return data;
  }
}
