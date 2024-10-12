class BeverageModel {
  BeverageModel({
    int? id,
    String? title,
    String? description,
    List<String>? ingredients,
    String? image,
  }) {
    _id = id;
    _title = title;
    _description = description;
    _ingredients = ingredients;
    _image = image;
  }

  BeverageModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _ingredients = json['ingredients'] != null ? json['ingredients'].cast<String>() : [];
    _image = json['image'];
  }

  int? _id;
  String? _title;
  String? _description;
  List<String>? _ingredients;
  String? _image;

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  List<String>? get ingredients => _ingredients;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['ingredients'] = _ingredients;
    map['image'] = _image;
    return map;
  }
}
