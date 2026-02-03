import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../pages/app_states_page.dart';
import '../pages/more_page.dart';
import '../pages/placeholder_page.dart';
import '../pages/setup_placeholder_page.dart';
import '../shell/app_shell.dart';
import '../../core/ui/pages/components_gallery_page.dart';

const setupLocation = '/setup';
const setupRouteName = 'setup';

const dashboardLocation = '/dashboard';
const dashboardRouteName = 'dashboard';
const dashboardTitle = 'Dashboard';

const membersLocation = '/members';
const membersRouteName = 'members';
const membersTitle = 'Members';

const contributionsLocation = '/contributions';
const contributionsRouteName = 'contributions';
const contributionsTitle = 'Contributions';

const moreLocation = '/more';
const moreRouteName = 'more';
const moreTitle = 'More';

const appStatesLocation = '/app-states';
const appStatesRouteName = 'appStates';
const appStatesTitle = 'App states';

const componentsLocation = '/components';
const componentsRouteName = 'components';
const componentsTitle = 'Components';

const drawLocation = '/draw';
const drawRouteName = 'draw';
const drawTitle = 'Draw';

const payoutLocation = '/payout';
const payoutRouteName = 'payout';
const payoutTitle = 'Payout';

const ledgerLocation = '/ledger';
const ledgerRouteName = 'ledger';
const ledgerTitle = 'Ledger';

const rulesLocation = '/rules';
const rulesRouteName = 'rules';
const rulesTitle = 'Rules';

const disputesLocation = '/disputes';
const disputesRouteName = 'disputes';
const disputesTitle = 'Disputes';

const settingsLocation = '/settings';
const settingsRouteName = 'settings';
const settingsTitle = 'Settings';

/// Temporary in-memory app configuration.
///
/// This will be replaced by persisted shomiti creation in later tasks (TS-101+).
final shomitiConfiguredProvider = StateProvider<bool>((ref) => false);

String? appRedirect({
  required bool isConfigured,
  required String location,
}) {
  final isSetup = location == setupLocation;

  if (!isConfigured && !isSetup) {
    return setupLocation;
  }

  if (isConfigured && isSetup) {
    return dashboardLocation;
  }

  return null;
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final isConfigured = ref.watch(shomitiConfiguredProvider);

  return GoRouter(
    initialLocation: dashboardLocation,
    routes: [
      GoRoute(
        path: setupLocation,
        name: setupRouteName,
        builder: (context, state) => const SetupPlaceholderPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(
          location: state.matchedLocation,
          child: child,
        ),
        routes: [
          GoRoute(
            path: dashboardLocation,
            name: dashboardRouteName,
            builder: (context, state) => const PlaceholderPage(
              title: dashboardTitle,
            ),
          ),
          GoRoute(
            path: membersLocation,
            name: membersRouteName,
            builder: (context, state) => const PlaceholderPage(
              title: membersTitle,
            ),
          ),
          GoRoute(
            path: contributionsLocation,
            name: contributionsRouteName,
            builder: (context, state) => const PlaceholderPage(
              title: contributionsTitle,
            ),
          ),
          GoRoute(
            path: moreLocation,
            name: moreRouteName,
            builder: (context, state) => const MorePage(),
          ),
          GoRoute(
            path: appStatesLocation,
            name: appStatesRouteName,
            builder: (context, state) => const AppStatesPage(),
          ),
          GoRoute(
            path: componentsLocation,
            name: componentsRouteName,
            builder: (context, state) => const ComponentsGalleryPage(),
          ),
          GoRoute(
            path: drawLocation,
            name: drawRouteName,
            builder: (context, state) => const PlaceholderPage(
              title: drawTitle,
            ),
          ),
          GoRoute(
            path: payoutLocation,
            name: payoutRouteName,
            builder: (context, state) => const PlaceholderPage(
              title: payoutTitle,
            ),
          ),
          GoRoute(
            path: ledgerLocation,
            name: ledgerRouteName,
            builder: (context, state) => const PlaceholderPage(
              title: ledgerTitle,
            ),
          ),
          GoRoute(
            path: rulesLocation,
            name: rulesRouteName,
            builder: (context, state) => const PlaceholderPage(
              title: rulesTitle,
            ),
          ),
          GoRoute(
            path: disputesLocation,
            name: disputesRouteName,
            builder: (context, state) => const PlaceholderPage(
              title: disputesTitle,
            ),
          ),
          GoRoute(
            path: settingsLocation,
            name: settingsRouteName,
            builder: (context, state) => const PlaceholderPage(
              title: settingsTitle,
            ),
          ),
        ],
      ),
    ],
    redirect: (context, state) => appRedirect(
      isConfigured: isConfigured,
      location: state.matchedLocation,
    ),
  );
});
