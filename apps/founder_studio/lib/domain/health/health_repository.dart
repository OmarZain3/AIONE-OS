import 'package:founder_studio/domain/health/health_status.dart';

/// Contract for retrieving application health information.
abstract class HealthRepository {
  Future<HealthStatus> getLocalStatus();

  Future<bool> isBackendReachable();
}
