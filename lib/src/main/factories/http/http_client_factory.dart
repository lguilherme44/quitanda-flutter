import 'package:http/http.dart';
import '../../../data/http/http.dart';
import '../../../infra/http/http_adapter.dart';
import '../../decorators/decorators.dart';
import '../cache/cache_local_storage_factory.dart';

class HttpClientFactory {
  static HttpClient makeHttpClientAdapter() => HttpAdapter(Client());

  static HttpClient makeAuthorizeHttpClientAdapter() =>
      AuthorizeHttpClientDecorator(
        httpClient: HttpAdapter(Client()),
        localStorage: makeLocalStorage(),
      );
}
