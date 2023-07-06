import 'package:goya/src/domain/models/products_model.dart';

class CartItemModel {
  ProductsModel item;
  int quantity;

  CartItemModel({required this.item, required this.quantity});
}

List<CartItemModel> cartItems = [
  CartItemModel(
    item: ProductsModel(
        description: 'description 1',
        imgUrl: 'imgUrl',
        itemName: 'Maça',
        price: 9.90,
        unit: 'un'),
    quantity: 2,
  ),
  CartItemModel(
    item: ProductsModel(
        description: 'description 2',
        imgUrl: 'imgUrl',
        itemName: 'Manga',
        price: 10.90,
        unit: 'un'),
    quantity: 1,
  ),
  CartItemModel(
    item: ProductsModel(
        description: 'description 3',
        imgUrl: 'imgUrl',
        itemName: 'Goiaba',
        price: 11.99,
        unit: 'un'),
    quantity: 3,
  ),
];
