import 'dart:convert';
import 'package:http/http.dart';
import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(url);
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll(
          {'content-type': 'application/json', 'accept': 'application/json'});
    final jsonBody = body != null ? jsonEncode(body) : null;
    late Response response;

    try {
      if (method == 'post') {
        response =
            await client.post(uri, headers: defaultHeaders, body: jsonBody);
      } else if (method == 'get') {
        response = await client.get(uri, headers: defaultHeaders);
      } else if (method == 'put') {
        response =
            await client.put(uri, headers: defaultHeaders, body: jsonBody);
      } else if (method == 'delete') {
        response = await client.delete(uri, headers: defaultHeaders);
      } else {
        throw HttpError.invalidMethod;
      }
    } catch (error) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
