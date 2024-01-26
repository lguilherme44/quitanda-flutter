import 'package:goya/src/domain/models/products_model.dart';

class CartItemModel {
  ProductsModel item;
  int quantity;

  CartItemModel({required this.item, required this.quantity});

  double totalPrice() => item.price * quantity;
}

List<CartItemModel> cartItems = [
  CartItemModel(
    item: ProductsModel(
        id: 1,
        description: 'description 1',
        imgUrl: 'assets/fruits/apple.png',
        itemName: 'Maça',
        price: 9.90,
        categoryId: 1,
        unit: 'kg'),
    quantity: 1,
  ),
  CartItemModel(
    item: ProductsModel(
        id: 2,
        description: 'description 2',
        imgUrl: 'assets/fruits/mango.png',
        itemName: 'Manga',
        price: 10.90,
        categoryId: 1,
        unit: 'un'),
    quantity: 1,
  ),
  CartItemModel(
    item: ProductsModel(
        id: 3,
        description: 'description 3',
        imgUrl: 'assets/fruits/guava.png',
        itemName: 'Goiaba',
        categoryId: 1,
        price: 11.99,
        unit: 'kg'),
    quantity: 3,
  ),
];
