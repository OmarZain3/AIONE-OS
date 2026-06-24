import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:founder_studio/core/constants.dart';
import 'package:founder_studio/domain/auth/auth_tokens.dart';
import 'package:founder_studio/domain/auth/auth_user.dart';

/// Low-level HTTP client for authentication endpoints.
class AuthApiClient {
  AuthApiClient({http.Client? client, String? baseUrl})
    : _client = client ?? http.Client(),
      _baseUrl = baseUrl ?? _resolveBackendUrl();

  final http.Client _client;
  final String _baseUrl;

  static String _resolveBackendUrl() {
    const envUrl = String.fromEnvironment('BACKEND_URL');
    if (envUrl.isNotEmpty) {
      return envUrl;
    }
    return AppConstants.defaultBackendUrl;
  }

  String get baseUrl => _baseUrl;

  Future<AuthTokens> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/auth/login/'),
      headers: _jsonHeaders(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    _throwIfError(response);
    return AuthTokens.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<AuthTokens> refresh({required String refreshToken}) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/auth/refresh/'),
      headers: _jsonHeaders(),
      body: jsonEncode({'refresh': refreshToken}),
    );
    _throwIfError(response);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return AuthTokens(
      accessToken: body['access'] as String,
      refreshToken: refreshToken,
    );
  }

  Future<void> verify({required String token}) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/auth/verify/'),
      headers: _jsonHeaders(),
      body: jsonEncode({'token': token}),
    );
    _throwIfError(response);
  }

  Future<AuthUser> currentUser({required String accessToken}) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/auth/me/'),
      headers: _jsonHeaders(accessToken: accessToken),
    );
    _throwIfError(response);
    return AuthUser.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<void> logout({
    required String accessToken,
    required String refreshToken,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/auth/logout/'),
      headers: _jsonHeaders(accessToken: accessToken),
      body: jsonEncode({'refresh': refreshToken}),
    );
    if (response.statusCode != 204 && response.statusCode != 401) {
      _throwIfError(response);
    }
  }

  Map<String, String> _jsonHeaders({String? accessToken}) {
    final headers = <String, String>{'Content-Type': 'application/json'};
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  void _throwIfError(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }
    String message = 'Request failed (${response.statusCode})';
    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final detail = body['detail'];
      if (detail is String) {
        message = detail;
      } else if (detail is List && detail.isNotEmpty) {
        message = detail.first.toString();
      }
    } catch (_) {
      if (kDebugMode) {
        message = response.body.isNotEmpty ? response.body : message;
      }
    }
    throw AuthApiException(message, statusCode: response.statusCode);
  }
}

/// Raised when an authentication API call fails.
class AuthApiException implements Exception {
  const AuthApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}
