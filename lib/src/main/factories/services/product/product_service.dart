import 'package:goya/src/data/services/product/product.dart';
import 'package:goya/src/main/factories/http/http_client_factory.dart';

ProductService makeProductService() {
  return ProductService(
      httpClient: HttpClientFactory.makeAuthorizeHttpClientAdapter());
}
