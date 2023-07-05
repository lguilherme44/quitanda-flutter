import 'package:http/http.dart';
import '../../../data/http/http.dart';
import '../../../infra/http/http_adapter.dart';
import '../../decorators/decorators.dart';

class HttpClientFactory {
  static String baseUrl = "http://192.168.0.131:3000/";

  static HttpClient makeAuthorizeHttpClientAdapter() =>
      AuthorizeHttpClientDecorator(
        apiUrl: baseUrl,
        httpClient: HttpAdapter(Client()),
      );
}
