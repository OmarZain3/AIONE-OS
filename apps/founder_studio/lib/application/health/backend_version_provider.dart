import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:founder_studio/infrastructure/health/health_api_client.dart';

/// Backend version metadata from the health endpoint.
class BackendVersionInfo {
  const BackendVersionInfo({
    required this.version,
    required this.environment,
    required this.isReachable,
  });

  final String version;
  final String environment;
  final bool isReachable;

  static const unknown = BackendVersionInfo(
    version: '—',
    environment: '—',
    isReachable: false,
  );
}

final backendVersionProvider = FutureProvider<BackendVersionInfo>((ref) async {
  final client = HealthApiClient(client: http.Client());
  try {
    final response = await client.fetchHealth();
    return BackendVersionInfo(
      version: response.version,
      environment: response.environment,
      isReachable: true,
    );
  } catch (_) {
    return BackendVersionInfo.unknown;
  }
});
