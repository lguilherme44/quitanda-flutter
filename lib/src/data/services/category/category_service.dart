import 'package:goya/src/domain/usecases/categories/getCategory.dart';
import 'package:goya/src/models/categoties_model.dart';
import '../../http/http.dart';

class CategoryService implements GetCategory {
  final HttpClient httpClient;

  CategoryService({required this.httpClient});

  @override
  Future<List<CategoriesModel>> load() async {
    final response = await httpClient.request(
      url: 'categories',
      method: 'get',
    );

    if (response == null) {
      throw Exception('Failed to fetch products');
    }

    final List<dynamic> responseData = response as List<dynamic>;

    final List<CategoriesModel> categories = responseData
        .map((json) => CategoriesModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return categories;
  }
}
