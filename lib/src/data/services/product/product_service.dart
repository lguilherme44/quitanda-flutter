import 'package:goya/src/domain/models/products_model.dart';
import '../../../domain/usecases/products/getProducts.dart';
import '../../http/http.dart';

class ProductService implements GetProducts {
  final HttpClient httpClient;

  ProductService({required this.httpClient});

  @override
  Future<List<ProductsModel>> load() async {
    final response = await httpClient.request(
      url: 'products',
      method: 'get',
    );

    if (response == null) {
      throw Exception('Failed to fetch products');
    }

    final List<dynamic> responseData = response as List<dynamic>;

    final List<ProductsModel> products = responseData
        .map((json) => ProductsModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return products;
  }

  Future<List<ProductsModel>> filterProductsFromCategory(
      int selectedCategory) async {
    final response = await httpClient.request(
      url: 'products/$selectedCategory',
      method: 'get',
    );

    if (response == null) {
      throw Exception('Failed to fetch products');
    }

    final List<dynamic> responseData = response as List<dynamic>;

    final List<ProductsModel> products = responseData
        .map((json) => ProductsModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return products;
  }
}
