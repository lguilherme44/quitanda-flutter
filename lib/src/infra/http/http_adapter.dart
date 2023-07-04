import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final http.Client client;

  HttpAdapter(this.client);

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final requestHeaders = headers ??
        {
          'content-type': 'application/json',
          'accept': 'application/json',
        };

    final requestBody = body != null ? jsonEncode(body) : null;

    final response = await client.post(
      Uri.parse(url),
      headers: requestHeaders,
      body: requestBody,
    );

    final dynamic responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('HTTP request failed with status ${response.statusCode}');
    }
  }
}
