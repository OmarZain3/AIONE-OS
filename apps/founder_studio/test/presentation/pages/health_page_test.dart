import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:founder_studio/application/health/health_providers.dart';
import 'package:founder_studio/domain/health/health_repository.dart';
import 'package:founder_studio/domain/health/health_status.dart';
import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/pages/health_page.dart';

class _FakeHealthRepository implements HealthRepository {
  @override
  Future<HealthStatus> getLocalStatus() async {
    return const HealthStatus(
      isHealthy: true,
      version: '0.1.0-alpha',
      backendReachable: true,
    );
  }

  @override
  Future<bool> isBackendReachable() async => true;
}

void main() {
  Widget wrap(Widget child) {
    return ProviderScope(
      overrides: [
        healthRepositoryProvider.overrideWithValue(_FakeHealthRepository()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    );
  }

  testWidgets('HealthPage displays status cards', (tester) async {
    await tester.pumpWidget(wrap(const HealthPage()));
    await tester.pumpAndSettle();

    expect(find.text('Health'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
    expect(find.text('Reachable'), findsOneWidget);
    expect(find.text('0.1.0-alpha'), findsOneWidget);
  });

  testWidgets('HealthPage shows loading indicator initially', (tester) async {
    await tester.pumpWidget(wrap(const HealthPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
