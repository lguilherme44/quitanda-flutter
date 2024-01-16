class ProductsModel {
  late int id;
  late String description;
  late String imgUrl;
  late String itemName;
  late double price;
  late String unit;

  ProductsModel({
    required this.id,
    required this.description,
    required this.imgUrl,
    required this.itemName,
    required this.price,
    required this.unit,
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    imgUrl = json['imgUrl'];
    itemName = json['itemName'];
    price = json['price'].toDouble();
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['imgUrl'] = imgUrl;
    data['itemName'] = itemName;
    data['price'] = price;
    data['unit'] = unit;
    return data;
  }
}
