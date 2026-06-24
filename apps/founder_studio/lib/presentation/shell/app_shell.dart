import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:founder_studio/l10n/app_localizations.dart';
import 'package:founder_studio/presentation/router/app_router.dart';
import 'package:founder_studio/presentation/widgets/connection_status_widget.dart';

/// Responsive application shell with drawer and bottom navigation.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _breakpointCompact = 600;
  static const _breakpointMedium = 840;

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final width = MediaQuery.sizeOf(context).width;

    final destinations = [
      NavigationDestination(
        icon: const Icon(Icons.dashboard_outlined),
        selectedIcon: const Icon(Icons.dashboard),
        label: l10n.navDashboard,
      ),
      NavigationDestination(
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        label: l10n.navSettings,
      ),
      NavigationDestination(
        icon: const Icon(Icons.person_outline),
        selectedIcon: const Icon(Icons.person),
        label: l10n.navProfile,
      ),
    ];

    final drawerDestinations = [
      _ShellDestination(
        icon: Icons.dashboard_outlined,
        selectedIcon: Icons.dashboard,
        label: l10n.navDashboard,
        route: AppRoutes.dashboard,
        index: 0,
      ),
      _ShellDestination(
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
        label: l10n.navSettings,
        route: AppRoutes.settings,
        index: 1,
      ),
      _ShellDestination(
        icon: Icons.person_outline,
        selectedIcon: Icons.person,
        label: l10n.navProfile,
        route: AppRoutes.profile,
        index: 2,
      ),
    ];

    if (width >= _breakpointMedium) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.appTitle),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: ConnectionStatusWidget(compact: true),
            ),
          ],
        ),
        body: Row(
          children: [
            NavigationRail(
              extended: width >= 1024,
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onDestinationSelected,
              labelType: width >= 1024
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              destinations: [
                for (final item in drawerDestinations)
                  NavigationRailDestination(
                    icon: Icon(item.icon),
                    selectedIcon: Icon(item.selectedIcon),
                    label: Text(item.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    if (width >= _breakpointCompact) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.appTitle),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: ConnectionStatusWidget(compact: true),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    l10n.appTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              for (final item in drawerDestinations)
                ListTile(
                  leading: Icon(
                    navigationShell.currentIndex == item.index
                        ? item.selectedIcon
                        : item.icon,
                  ),
                  title: Text(item.label),
                  selected: navigationShell.currentIndex == item.index,
                  onTap: () {
                    Navigator.pop(context);
                    _onDestinationSelected(item.index);
                  },
                ),
            ],
          ),
        ),
        body: navigationShell,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_titleForIndex(l10n, navigationShell.currentIndex)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: ConnectionStatusWidget(compact: true),
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: destinations,
      ),
    );
  }

  String _titleForIndex(AppLocalizations l10n, int index) {
    return switch (index) {
      0 => l10n.navDashboard,
      1 => l10n.navSettings,
      2 => l10n.navProfile,
      _ => l10n.appTitle,
    };
  }
}

class _ShellDestination {
  const _ShellDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.route,
    required this.index,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String route;
  final int index;
}
