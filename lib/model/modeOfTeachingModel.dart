class ModeOfTeachingModel {
  bool? isChecked;
  String? title;

  ModeOfTeachingModel({this.isChecked, this.title});

  ModeOfTeachingModel.fromJson(Map<String, dynamic> json) {
    isChecked = json['isChecked'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isChecked'] = this.isChecked;
    data['title'] = this.title;
    return data;
  }
}
