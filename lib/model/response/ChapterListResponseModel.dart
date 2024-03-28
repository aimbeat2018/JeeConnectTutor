class ChapterListResponseModel {
  String? status;
  List<ChapterListModel>? data;

  ChapterListResponseModel({this.status, this.data});

  ChapterListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ChapterListModel>[];
      json['data'].forEach((v) {
        data!.add(new ChapterListModel.fromJson(v));
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

class ChapterListModel {
  String? chapters;

  ChapterListModel({this.chapters});

  ChapterListModel.fromJson(Map<String, dynamic> json) {
    chapters = json['chapters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapters'] = this.chapters;
    return data;
  }
}
