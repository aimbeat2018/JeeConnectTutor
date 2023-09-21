class CategoryModel {
  String? id;
  String? code;
  String? name;
  String? parent;
  String? slug;
  String? dateAdded;
  String? lastModified;
  String? fontAwesomeClass;
  String? thumbnail;
  List<SubCategories>? subCategories;

  CategoryModel(
      {this.id,
      this.code,
      this.name,
      this.parent,
      this.slug,
      this.dateAdded,
      this.lastModified,
      this.fontAwesomeClass,
      this.thumbnail,
      this.subCategories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    parent = json['parent'];
    slug = json['slug'];
    dateAdded = json['date_added'];
    lastModified = json['last_modified'];
    fontAwesomeClass = json['font_awesome_class'];
    thumbnail = json['thumbnail'];
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['parent'] = this.parent;
    data['slug'] = this.slug;
    data['date_added'] = this.dateAdded;
    data['last_modified'] = this.lastModified;
    data['font_awesome_class'] = this.fontAwesomeClass;
    data['thumbnail'] = this.thumbnail;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  String? id;
  String? code;
  String? name;
  String? parent;
  String? slug;
  String? dateAdded;
  String? lastModified;
  String? fontAwesomeClass;
  String? thumbnail;

  SubCategories(
      {this.id,
      this.code,
      this.name,
      this.parent,
      this.slug,
      this.dateAdded,
      this.lastModified,
      this.fontAwesomeClass,
      this.thumbnail});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    parent = json['parent'];
    slug = json['slug'];
    dateAdded = json['date_added'];
    lastModified = json['last_modified'];
    fontAwesomeClass = json['font_awesome_class'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['parent'] = this.parent;
    data['slug'] = this.slug;
    data['date_added'] = this.dateAdded;
    data['last_modified'] = this.lastModified;
    data['font_awesome_class'] = this.fontAwesomeClass;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
