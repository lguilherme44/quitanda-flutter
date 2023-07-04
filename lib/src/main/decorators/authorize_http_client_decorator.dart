import '../../data/cache/local_storage.dart';
import '../../data/http/http.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  final HttpClient httpClient;
  final CacheLocalStorage localStorage;

  AuthorizeHttpClientDecorator({
    required this.httpClient,
    required this.localStorage,
  });

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final authorizedHeaders = headers ?? {};

      if (body != null) {
        body = {...body};
      }

      return await httpClient.request(
        url: url,
        method: method,
        body: body,
        headers: authorizedHeaders,
      );
    } catch (error) {
      if (error is HttpError && error != HttpError.forbidden) {
        rethrow;
      } else {
        await localStorage.clear();
        throw HttpError.forbidden;
      }
    }
  }
}
