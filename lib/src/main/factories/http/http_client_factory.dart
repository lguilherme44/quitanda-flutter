import 'package:http/http.dart';
import '../../../data/http/http.dart';
import '../../../infra/http/http_adapter.dart';
import '../../decorators/decorators.dart';

class HttpClientFactory {
  static String baseUrl = "https://fine-tan-baseball-cap.cyclic.app/";

  static HttpClient makeAuthorizeHttpClientAdapter() =>
      AuthorizeHttpClientDecorator(
        apiUrl: baseUrl,
        httpClient: HttpAdapter(Client()),
      );
}
