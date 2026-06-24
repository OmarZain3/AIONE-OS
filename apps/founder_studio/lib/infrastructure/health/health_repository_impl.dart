import 'package:founder_studio/core/constants.dart';
import 'package:founder_studio/domain/health/health_repository.dart';
import 'package:founder_studio/domain/health/health_status.dart';
import 'package:founder_studio/infrastructure/health/health_api_client.dart';

/// Infrastructure implementation of [HealthRepository].
class HealthRepositoryImpl implements HealthRepository {
  HealthRepositoryImpl({HealthApiClient? apiClient})
    : _apiClient = apiClient ?? HealthApiClient();

  final HealthApiClient _apiClient;

  @override
  Future<HealthStatus> getLocalStatus() async {
    final backendReachable = await isBackendReachable();
    return HealthStatus(
      isHealthy: true,
      version: AppConstants.appVersion,
      backendReachable: backendReachable,
    );
  }

  @override
  Future<bool> isBackendReachable() => _apiClient.ping();
}
