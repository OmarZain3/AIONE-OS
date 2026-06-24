import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:founder_studio/domain/health/health_repository.dart';
import 'package:founder_studio/domain/health/health_status.dart';
import 'package:founder_studio/infrastructure/health/health_repository_impl.dart';

final healthRepositoryProvider = Provider<HealthRepository>((ref) {
  return HealthRepositoryImpl();
});

final healthStatusProvider = FutureProvider<HealthStatus>((ref) async {
  final repository = ref.watch(healthRepositoryProvider);
  return repository.getLocalStatus();
});
