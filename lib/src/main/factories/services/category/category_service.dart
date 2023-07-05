import 'package:goya/src/data/services/category/category_service.dart';
import 'package:goya/src/main/factories/http/http_client_factory.dart';

CategoryService makeCategoryService() {
  return CategoryService(
      httpClient: HttpClientFactory.makeAuthorizeHttpClientAdapter());
}
