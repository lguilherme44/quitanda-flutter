class ItemModel {
  String itemName;
  String imgUrl;
  String unit;
  double price;
  String description;

  ItemModel({
    required this.itemName,
    required this.imgUrl,
    required this.unit,
    required this.price,
    required this.description,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      itemName: json['itemName'],
      imgUrl: json['imgUrl'],
      unit: json['unit'],
      price: json['price'].toDouble(),
      description: json['description'],
    );
  }
}
