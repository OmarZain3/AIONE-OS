import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:founder_studio/core/constants.dart';
import 'package:founder_studio/domain/project/project.dart';
import 'package:founder_studio/domain/project/project_repository.dart';

/// Low-level HTTP client for project endpoints.
class ProjectApiClient {
  ProjectApiClient({required http.Client client, String? baseUrl})
    : _client = client,
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

  Future<PaginatedProjects> listProjects(ProjectListQuery query) async {
    final uri = Uri.parse('$_baseUrl/api/projects/').replace(
      queryParameters: {
        if (query.search != null && query.search!.isNotEmpty)
          'search': query.search!,
        if (query.status != null) 'status': query.status!.apiValue,
        'page': '${query.page}',
        'ordering': query.ordering,
      },
    );
    final response = await _client.get(uri, headers: _jsonHeaders());
    _throwIfError(response);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final results = (body['results'] as List<dynamic>)
        .map((item) => Project.fromJson(item as Map<String, dynamic>))
        .toList();
    return PaginatedProjects(
      count: body['count'] as int,
      results: results,
      next: body['next'] as String?,
      previous: body['previous'] as String?,
    );
  }

  Future<Project> getProject(String id) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/projects/$id/'),
      headers: _jsonHeaders(),
    );
    _throwIfError(response);
    return Project.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<Project> createProject(Project project) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/projects/'),
      headers: _jsonHeaders(),
      body: jsonEncode(project.toCreateJson()),
    );
    _throwIfError(response);
    return Project.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<Project> updateProject(Project project) async {
    final response = await _client.patch(
      Uri.parse('$_baseUrl/api/projects/${project.id}/'),
      headers: _jsonHeaders(),
      body: jsonEncode(project.toUpdateJson()),
    );
    _throwIfError(response);
    return Project.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<void> deleteProject(String id) async {
    final response = await _client.delete(
      Uri.parse('$_baseUrl/api/projects/$id/'),
      headers: _jsonHeaders(),
    );
    if (response.statusCode != 204) {
      _throwIfError(response);
    }
  }

  Map<String, String> _jsonHeaders() {
    return const {'Content-Type': 'application/json'};
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
      }
    } catch (_) {
      if (kDebugMode && response.body.isNotEmpty) {
        message = response.body;
      }
    }
    throw ProjectApiException(message, statusCode: response.statusCode);
  }
}

/// Raised when a project API call fails.
class ProjectApiException implements Exception {
  const ProjectApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}
