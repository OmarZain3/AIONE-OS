/// Platform health entity — no Flutter dependencies.
class HealthStatus {
  const HealthStatus({
    required this.isHealthy,
    required this.version,
    required this.backendReachable,
  });

  final bool isHealthy;
  final String version;
  final bool backendReachable;
}
