import 'package:goya/src/domain/models/products_model.dart';

class CartItemModel {
  final ProductsModel product;
  int quantity;

  CartItemModel({required this.product, this.quantity = 1});

  double totalPrice() => product.price * quantity;
}
