import 'package:goya/src/models/item_model.dart';
import '../../../domain/usecases/products/getProducts.dart';
import '../../http/http.dart';

class ProductService implements GetProducts {
  final HttpClient httpClient;

  ProductService({required this.httpClient});

  @override
  Future<List<ItemModel>> load() async {
    final response = await httpClient.request(
      url: 'products',
      method: 'get',
    );

    if (response == null) {
      throw Exception('Failed to fetch products');
    }

    final List<dynamic> responseData = response as List<dynamic>;
    final List<dynamic> productsData = responseData.isNotEmpty
        ? responseData[0]['items'] as List<dynamic>
        : [];

    final List<ItemModel> products = productsData
        .map((json) => ItemModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return products;
  }
}
