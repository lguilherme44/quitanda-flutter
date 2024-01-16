class CategoriesModel {
  int id;
  String name;

  CategoriesModel({
    required this.id,
    required this.name,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
