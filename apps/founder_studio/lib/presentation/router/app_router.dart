import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:founder_studio/application/auth/auth_providers.dart';
import 'package:founder_studio/application/auth/auth_state.dart';
import 'package:founder_studio/presentation/pages/dashboard_page.dart';
import 'package:founder_studio/presentation/pages/login_page.dart';
import 'package:founder_studio/presentation/pages/profile_page.dart';
import 'package:founder_studio/presentation/pages/project_details_page.dart';
import 'package:founder_studio/presentation/pages/settings_page.dart';
import 'package:founder_studio/presentation/pages/splash_page.dart';
import 'package:founder_studio/presentation/shell/app_shell.dart';

/// Application route paths.
abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const settings = '/settings';
  static const profile = '/profile';
  static const projectDetailBase = '/projects';

  static String projectDetail(String id) => '$projectDetailBase/$id';
}

/// GoRouter configuration with authentication guards.
class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter(Ref ref) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: AppRoutes.splash,
      redirect: (context, state) {
        final authState = ref.read(authProvider);
        final location = state.matchedLocation;
        final isSplash = location == AppRoutes.splash;
        final isLogin = location == AppRoutes.login;
        final isAuthenticated = authState is AuthAuthenticated;
        final isLoading = authState is AuthInitial || authState is AuthLoading;

        if (isLoading && !isSplash) {
          return AppRoutes.splash;
        }

        if (!isLoading && isSplash && !isAuthenticated) {
          return AppRoutes.login;
        }

        if (!isAuthenticated && !isSplash && !isLogin) {
          return AppRoutes.login;
        }

        if (isAuthenticated && (isLogin || isSplash)) {
          return AppRoutes.dashboard;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '${AppRoutes.projectDetailBase}/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ProjectDetailsPage(projectId: id);
          },
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return AppShell(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.dashboard,
                  builder: (context, state) => const DashboardPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.settings,
                  builder: (context, state) => const SettingsPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.profile,
                  builder: (context, state) => const ProfilePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
