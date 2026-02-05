import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.location, required this.child, super.key});

  final String location;
  final Widget child;

  int get _selectedIndex {
    if (location.startsWith(membersLocation)) return 1;
    if (location.startsWith(contributionsLocation)) return 2;
    if (_isMoreRoute(location)) return 3;
    return switch (location) {
      _ => 0,
    };
  }

  bool _isMoreRoute(String location) {
    const moreRoutes = [
      moreLocation,
      drawLocation,
      payoutLocation,
      ledgerLocation,
      auditLocation,
      rulesLocation,
      defaultsLocation,
      disputesLocation,
      settingsLocation,
      componentsLocation,
      appStatesLocation,
      governanceLocation,
    ];

    return moreRoutes.any(location.startsWith);
  }

  @override
  Widget build(BuildContext context) {
    final title = switch (_selectedIndex) {
      0 => dashboardTitle,
      1 => membersTitle,
      2 => contributionsTitle,
      _ => moreTitle,
    };

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          final destination = switch (index) {
            0 => dashboardLocation,
            1 => membersLocation,
            2 => contributionsLocation,
            _ => moreLocation,
          };

          context.go(destination);
        },
        destinations: const [
          NavigationDestination(
            key: Key('nav_dashboard'),
            icon: Icon(Icons.dashboard_outlined, key: Key('nav_dashboard')),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            key: Key('nav_members'),
            icon: Icon(Icons.group_outlined, key: Key('nav_members')),
            selectedIcon: Icon(Icons.group),
            label: 'Members',
          ),
          NavigationDestination(
            key: Key('nav_dues'),
            icon: Icon(Icons.payments_outlined, key: Key('nav_dues')),
            selectedIcon: Icon(Icons.payments),
            label: 'Dues',
          ),
          NavigationDestination(
            key: Key('nav_more'),
            icon: Icon(Icons.more_horiz, key: Key('nav_more')),
            selectedIcon: Icon(Icons.more),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
