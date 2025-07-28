// lib/src/services/network_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../utils/constants.dart';

class NetworkService {
  final http.Client _client = http.Client();

  /// GET request with Authorization header
  Future<Map<String, dynamic>> get(String endpoint, String token) async {
    final uri = Uri.parse('${AppConstants.baseUrl}$endpoint');
    final headers = {
      'Authorization': 'Bearer $token',
    };

    debugPrint('GET ${uri.toString()}');
    debugPrint('Headers: $headers');

    try {
      final response = await _client.get(uri, headers: headers);
      return _handleResponse(response);
    } on Exception catch (e) {
      debugPrint('Network Error: $e');
      return {
        'success': false,
        'message': 'Network error: $e',
        'statusCode': 500,
        'data': null,
      };
    }
  }

  /// POST request (with optional token for authenticated endpoints)
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body,
      [String? token]) async {
    final uri = Uri.parse('${AppConstants.baseUrl}$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    debugPrint('POST ${uri.toString()}');
    debugPrint('Headers: $headers');
    debugPrint('Body: ${jsonEncode(body)}');

    try {
      final response = await _client.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } on Exception catch (e) {
      debugPrint('Network Error: $e');
      return {
        'success': false,
        'message': 'Network error: $e',
        'statusCode': 500,
        'data': null,
      };
    }
  }

  /// PUT request (for updates)
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body,
      [String? token]) async {
    final uri = Uri.parse('${AppConstants.baseUrl}$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    debugPrint('PUT ${uri.toString()}');
    debugPrint('Headers: $headers');
    debugPrint('Body: ${jsonEncode(body)}');

    try {
      final response = await _client.put(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } on Exception catch (e) {
      debugPrint('Network Error: $e');
      return {
        'success': false,
        'message': 'Network error: $e',
        'statusCode': 500,
        'data': null,
      };
    }
  }

  /// Handle HTTP response and parse JSON
  Map<String, dynamic> _handleResponse(http.Response response) {
    debugPrint('Response (${response.statusCode}): ${response.body}');

    try {
      final body = jsonDecode(response.body);

      if (body is Map) {
        return {
          'success': body['success'] ??
              (response.statusCode >= 200 && response.statusCode < 300),
          'statusCode': response.statusCode,
          'message': body['message'] ?? 'Request completed',
          'data': body['data'],
        };
      } else {
        return {
          'success': response.statusCode >= 200 && response.statusCode < 300,
          'statusCode': response.statusCode,
          'message': 'Request completed',
          'data': body,
        };
      }
    } catch (e) {
      debugPrint('JSON Parse Error: $e');
      return {
        'success': false,
        'statusCode': response.statusCode,
        'message': 'Invalid JSON response',
        'data': null,
      };
    }
  }

  /// Close the client (call on app shutdown)
  Future<void> close() async {
    _client.close();
  }
}
