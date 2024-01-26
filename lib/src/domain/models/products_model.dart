class ProductsModel {
  final int id;
  final int categoryId;
  final String description;
  final String imgUrl;
  final String itemName;
  final double price;
  final String unit;

  ProductsModel({
    required this.id,
    required this.categoryId,
    required this.description,
    required this.imgUrl,
    required this.itemName,
    required this.price,
    required this.unit,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      categoryId: json['categoryid'],
      description: json['description'],
      imgUrl: json['imgurl'],
      itemName: json['itemname'],
      price: double.parse(json['price']),
      unit: json['unit'],
    );
  }
}
