import 'package:http/http.dart';
import '../../../data/http/http.dart';
import '../../../infra/http/http_adapter.dart';
import '../../decorators/decorators.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpClientFactory {
  static String get baseUrl => dotenv.env['API_URL']!;

  static HttpClient makeAuthorizeHttpClientAdapter() =>
      AuthorizeHttpClientDecorator(
        apiUrl: baseUrl,
        httpClient: HttpAdapter(Client()),
      );
}
