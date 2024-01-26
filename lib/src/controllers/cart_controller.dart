import 'package:flutter/foundation.dart';
import 'package:goya/src/domain/models/cart_item_model.dart';
import 'package:goya/src/domain/models/products_model.dart';

enum CartState { idle, success, error, loading }

class CartController extends ChangeNotifier {
  var state = CartState.idle;

  List<CartItemModel> cartItems = [];

  void addToCart(ProductsModel product) {
    var existingItemIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingItemIndex != -1) {
      cartItems[existingItemIndex].quantity++;
    } else {
      cartItems.add(CartItemModel(product: product));
    }
    notifyListeners();
  }

  void updateQuantity(ProductsModel product, int quantity) {
    var existingItemIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingItemIndex != -1 && quantity > 0) {
      cartItems[existingItemIndex].quantity = quantity;
    }
    notifyListeners();
  }

  void removeFromCart(ProductsModel product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void cleanCart() {
    cartItems = [];
    notifyListeners();
  }

  double cartTotalPrice() {
    double total = 0;

    for (var item in cartItems) {
      total += item.totalPrice();
    }

    return total;
  }
}
