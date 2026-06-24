import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:founder_studio/core/constants.dart';

/// Parsed health endpoint payload.
class HealthApiResponse {
  const HealthApiResponse({
    required this.status,
    required this.service,
    required this.version,
    required this.environment,
  });

  final String status;
  final String service;
  final String version;
  final String environment;

  factory HealthApiResponse.fromJson(Map<String, dynamic> json) {
    return HealthApiResponse(
      status: json['status'] as String? ?? 'unknown',
      service: json['service'] as String? ?? 'unknown',
      version: json['version'] as String? ?? '—',
      environment: json['environment'] as String? ?? '—',
    );
  }
}

/// HTTP client for backend health checks.
class HealthApiClient {
  HealthApiClient({http.Client? client, String? baseUrl})
    : _client = client ?? http.Client(),
      _baseUrl = baseUrl ?? _resolveBackendUrl();

  final http.Client _client;
  final String _baseUrl;

  static String _resolveBackendUrl() {
    const envUrl = String.fromEnvironment('BACKEND_URL');
    if (envUrl.isNotEmpty) {
      return envUrl;
    }
    if (kIsWeb) {
      return AppConstants.defaultBackendUrl;
    }
    return AppConstants.defaultBackendUrl;
  }

  Future<bool> ping() async {
    try {
      final response = await fetchHealth();
      return response.status == 'ok';
    } catch (_) {
      return false;
    }
  }

  Future<HealthApiResponse> fetchHealth() async {
    final response = await _client
        .get(Uri.parse('$_baseUrl/api/health/'))
        .timeout(const Duration(seconds: 5));
    if (response.statusCode != 200) {
      throw Exception('Health check failed (${response.statusCode})');
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return HealthApiResponse.fromJson(body);
  }
}
