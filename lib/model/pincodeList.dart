class PincodeList {
  String? name;
  int? index;

  PincodeList({this.name,this.index});

  PincodeList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
