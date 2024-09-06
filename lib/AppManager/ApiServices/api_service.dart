import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiService {
  static const String _defaultBaseUrl = "https://api.aladhan.com/";
  static ApiService? _instance;
  final Logger _logger = Logger();

  // Private constructor to restrict instantiation from outside
  ApiService._internal();

  // Public factory constructor to return the same instance every time
  factory ApiService() {
    _instance ??= ApiService._internal();
    return _instance!;
  }

  // GET request with optional custom base URL
  Future<dynamic> get(String endpoint, {String? customBaseUrl, Map<String, String>? headers}) async {
    final url = customBaseUrl ?? _defaultBaseUrl;
    return await _sendRequest(() => http.get(Uri.parse('$url$endpoint'), headers: headers));
  }

  // Unified request handling with retries and logging
  Future<dynamic> _sendRequest(Future<http.Response> Function() request, {int retries = 3}) async {
    int attempt = 0;
    while (attempt < retries) {
      try {
        _logger.i("Sending request (attempt $attempt)...");
        final response = await request().timeout(const Duration(seconds: 10));
        _logger.i("Response received: ${response.statusCode}");
        return _handleResponse(response);
      } on TimeoutException {
        attempt++;
        if (attempt == retries) throw Exception("The request timed out after $retries attempts");
      } on SocketException {
        throw NoInternetException();
      } catch (e) {
        throw ApiException("An unexpected error occurred: $e");
      }
    }
  }

  // Response handler based on status code
  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw ApiException("Bad request: ${response.body}");
      case 401:
      case 403:
        throw ApiException("Unauthorized: ${response.body}");
      case 404:
        throw ApiException("Not found: ${response.body}");
      case 500:
      default:
        throw ApiException("Server error: ${response.body}");
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => "ApiException: $message";
}

class NoInternetException extends ApiException {
  NoInternetException() : super("No internet connection");
}
