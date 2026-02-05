import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../pages/app_states_page.dart';
import '../pages/more_page.dart';
import '../pages/placeholder_page.dart';
import '../shell/app_shell.dart';
import '../../core/ui/pages/components_gallery_page.dart';
import '../../features/audit/presentation/audit_log_page.dart';
import '../../features/ledger/presentation/ledger_page.dart';
import '../../features/members/presentation/governance/governance_page.dart';
import '../../features/members/presentation/governance/member_signoff_page.dart';
import '../../features/members/presentation/governance/roles_assignment_page.dart';
import '../../features/members/presentation/member_detail_page.dart';
import '../../features/members/presentation/member_form_page.dart';
import '../../features/members/presentation/members_page.dart';
import '../../features/rules/presentation/rules_page.dart';
import '../../features/shares/presentation/shares_page.dart';
import '../../features/risk_controls/presentation/risk_controls_page.dart';
import '../../features/membership_changes/presentation/membership_changes_page.dart';
import '../../features/contributions/presentation/contributions_page.dart';
import '../../features/defaults/presentation/defaults_page.dart';
import '../../features/draw/presentation/draw_page.dart';
import '../../features/draw/presentation/draw_record_details_page.dart';
import '../../features/draw/presentation/redo_draw_page.dart';
import '../../features/draw/presentation/run_draw_page.dart';
import '../../features/draw/presentation/witness_signoff_page.dart';
import '../../features/contributions/domain/value_objects/billing_month.dart';
import '../../features/shomiti_setup/presentation/setup_wizard_page.dart';
import '../../features/shomiti_setup/presentation/providers/shomiti_setup_providers.dart';

const setupLocation = '/setup';
const setupRouteName = 'setup';

const dashboardLocation = '/dashboard';
const dashboardRouteName = 'dashboard';
const dashboardTitle = 'Dashboard';

const membersLocation = '/members';
const membersRouteName = 'members';
const membersTitle = 'Members';

const memberAddRouteName = 'memberAdd';
const memberDetailsRouteName = 'memberDetails';
const memberEditRouteName = 'memberEdit';

const memberAddLocation = '/members/add';
String memberDetailsLocation(String memberId) => '/members/$memberId';
String memberEditLocation(String memberId) => '/members/$memberId/edit';

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

const drawRunLocation = '/draw/run';
const drawRunRouteName = 'drawRun';

const drawRecordLocation = '/draw/record';
const drawRecordRouteName = 'drawRecord';

const drawWitnessesLocation = '/draw/witnesses';
const drawWitnessesRouteName = 'drawWitnesses';

const drawRedoLocation = '/draw/redo';
const drawRedoRouteName = 'drawRedo';

const payoutLocation = '/payout';
const payoutRouteName = 'payout';
const payoutTitle = 'Payout';

const ledgerLocation = '/ledger';
const ledgerRouteName = 'ledger';
const ledgerTitle = 'Ledger';

const rulesLocation = '/rules';
const rulesRouteName = 'rules';
const rulesTitle = 'Rules';

const sharesLocation = '/shares';
const sharesRouteName = 'shares';
const sharesTitle = 'Shares';

const riskControlsLocation = '/risk-controls';
const riskControlsRouteName = 'riskControls';
const riskControlsTitle = 'Risk controls';

const membershipChangesLocation = '/membership-changes';
const membershipChangesRouteName = 'membershipChanges';
const membershipChangesTitle = 'Membership changes';

const defaultsLocation = '/defaults';
const defaultsRouteName = 'defaults';
const defaultsTitle = 'Defaults';

const disputesLocation = '/disputes';
const disputesRouteName = 'disputes';
const disputesTitle = 'Disputes';

const settingsLocation = '/settings';
const settingsRouteName = 'settings';
const settingsTitle = 'Settings';

const auditLocation = '/audit';
const auditRouteName = 'audit';
const auditTitle = 'Audit log';

const governanceLocation = '/governance';
const governanceRouteName = 'governance';
const governanceTitle = 'Governance';

const governanceRolesLocation = '/governance/roles';
const governanceRolesRouteName = 'governanceRoles';
const governanceRolesTitle = 'Roles';

const governanceSignoffLocation = '/governance/signoff';
const governanceSignoffRouteName = 'governanceSignoff';
const governanceSignoffTitle = 'Sign-off';

/// Whether a Shomiti is configured in local persistence.
final shomitiConfiguredProvider = Provider<bool>((ref) {
  final active = ref.watch(activeShomitiProvider);
  return active.maybeWhen(
    data: (shomiti) => shomiti != null,
    orElse: () => false,
  );
});

String? appRedirect({required bool isConfigured, required String location}) {
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
        builder: (context, state) => const SetupWizardPage(),
      ),
      GoRoute(
        path: memberAddLocation,
        name: memberAddRouteName,
        builder: (context, state) =>
            const MemberFormPage(mode: MemberFormMode.add),
      ),
      GoRoute(
        path: '/members/:memberId/edit',
        name: memberEditRouteName,
        builder: (context, state) => MemberFormPage(
          mode: MemberFormMode.edit,
          memberId: state.pathParameters['memberId']!,
        ),
      ),
      GoRoute(
        path: '/members/:memberId',
        name: memberDetailsRouteName,
        builder: (context, state) =>
            MemberDetailPage(memberId: state.pathParameters['memberId']!),
      ),
      ShellRoute(
        builder: (context, state, child) =>
            AppShell(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(
            path: dashboardLocation,
            name: dashboardRouteName,
            builder: (context, state) =>
                const PlaceholderPage(title: dashboardTitle),
          ),
          GoRoute(
            path: membersLocation,
            name: membersRouteName,
            builder: (context, state) => const MembersPage(),
          ),
          GoRoute(
            path: contributionsLocation,
            name: contributionsRouteName,
            builder: (context, state) =>
                const ContributionsPage(),
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
            builder: (context, state) => const DrawPage(),
          ),
          GoRoute(
            path: drawRecordLocation,
            name: drawRecordRouteName,
            builder: (context, state) => const DrawRecordDetailsPage(),
          ),
          GoRoute(
            path: drawWitnessesLocation,
            name: drawWitnessesRouteName,
            builder: (context, state) {
              final extra = state.extra;
              final drawId = extra is String ? extra : '';
              return WitnessSignoffPage(drawId: drawId);
            },
          ),
          GoRoute(
            path: drawRedoLocation,
            name: drawRedoRouteName,
            builder: (context, state) {
              final extra = state.extra;
              final drawId = extra is String ? extra : '';
              return RedoDrawPage(drawId: drawId);
            },
          ),
          GoRoute(
            path: drawRunLocation,
            name: drawRunRouteName,
            builder: (context, state) {
              final args = state.extra;
              if (args is RunDrawArgs) {
                return RunDrawPage(args: args);
              }

              return RunDrawPage(
                args: RunDrawArgs(
                  shomitiId: 'unknown',
                  ruleSetVersionId: 'unknown',
                  month: args is BillingMonth
                      ? args
                      : BillingMonth.fromDate(DateTime.now()),
                  eligibleShares: const [],
                ),
              );
            },
          ),
          GoRoute(
            path: payoutLocation,
            name: payoutRouteName,
            builder: (context, state) =>
                const PlaceholderPage(title: payoutTitle),
          ),
          GoRoute(
            path: ledgerLocation,
            name: ledgerRouteName,
            builder: (context, state) => const LedgerPage(),
          ),
          GoRoute(
            path: auditLocation,
            name: auditRouteName,
            builder: (context, state) => const AuditLogPage(),
          ),
          GoRoute(
            path: rulesLocation,
            name: rulesRouteName,
            builder: (context, state) => const RulesPage(),
          ),
          GoRoute(
            path: sharesLocation,
            name: sharesRouteName,
            builder: (context, state) => const SharesPage(),
          ),
          GoRoute(
            path: riskControlsLocation,
            name: riskControlsRouteName,
            builder: (context, state) => const RiskControlsPage(),
          ),
          GoRoute(
            path: membershipChangesLocation,
            name: membershipChangesRouteName,
            builder: (context, state) => const MembershipChangesPage(),
          ),
          GoRoute(
            path: defaultsLocation,
            name: defaultsRouteName,
            builder: (context, state) => const DefaultsPage(),
          ),
          GoRoute(
            path: disputesLocation,
            name: disputesRouteName,
            builder: (context, state) =>
                const PlaceholderPage(title: disputesTitle),
          ),
          GoRoute(
            path: settingsLocation,
            name: settingsRouteName,
            builder: (context, state) =>
                const PlaceholderPage(title: settingsTitle),
          ),
          GoRoute(
            path: governanceLocation,
            name: governanceRouteName,
            builder: (context, state) => const GovernancePage(),
            routes: [
              GoRoute(
                path: 'roles',
                name: governanceRolesRouteName,
                builder: (context, state) => const RolesAssignmentPage(),
              ),
              GoRoute(
                path: 'signoff',
                name: governanceSignoffRouteName,
                builder: (context, state) => const MemberSignoffPage(),
              ),
            ],
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
