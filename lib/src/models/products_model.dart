class ProductsModel {
  late String description;
  late String imgUrl;
  late String itemName;
  late double price; // Alterado de int para double
  late String unit;

  ProductsModel({
    required this.description,
    required this.imgUrl,
    required this.itemName,
    required this.price,
    required this.unit,
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    imgUrl = json['imgUrl'];
    itemName = json['itemName'];
    price = json['price'].toDouble(); // Convertido para double
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['imgUrl'] = imgUrl;
    data['itemName'] = itemName;
    data['price'] = price;
    data['unit'] = unit;
    return data;
  }
}
