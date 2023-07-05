import '../../data/http/http.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  final String apiUrl;
  final HttpClient httpClient;

  AuthorizeHttpClientDecorator({
    required this.apiUrl,
    required this.httpClient,
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
        url: '$apiUrl$url',
        method: method,
        body: body,
        headers: authorizedHeaders,
      );
    } catch (error) {
      if (error is HttpError && error != HttpError.forbidden) {
        rethrow;
      } else {
        throw HttpError.forbidden;
      }
    }
  }
}
