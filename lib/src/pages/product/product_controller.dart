import 'package:flutter/foundation.dart';
import 'package:goya/src/domain/models/products_model.dart';
import 'package:goya/src/main/factories/services/product/product_service.dart';

enum ProductState { idle, success, error, loading }

class ProductController extends ChangeNotifier {
  final productService = makeProductService();

  var state = ProductState.idle;

  late List<ProductsModel> products;

  Future<void> fetchProducts() async {
    state = ProductState.loading;
    notifyListeners();

    try {
      products = await productService.load();
      state = ProductState.success;
      notifyListeners();
    } catch (e) {
      state = ProductState.error;
      notifyListeners();
    } finally {
      state = ProductState.idle;
      notifyListeners();
    }
  }

  Future<void> fetchProductsFromId(int selectedCategory) async {
    state = ProductState.loading;
    notifyListeners();

    try {
      products =
          await productService.filterProductsFromCategory(selectedCategory);
      state = ProductState.success;
      notifyListeners();
    } catch (e) {
      state = ProductState.error;
      notifyListeners();
    } finally {
      state = ProductState.idle;
      notifyListeners();
    }
  }
}
