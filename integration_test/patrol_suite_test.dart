import 'patrol_e2e_test.dart' as patrol_e2e_test;
import 'patrol_smoke_test.dart' as patrol_smoke_test;
import 'ts_101_setup_wizard_e2e_test.dart' as ts_101_setup_wizard_e2e_test;
import 'ts_002_components_gallery_e2e_test.dart'
    as ts_002_components_gallery_e2e_test;
import 'ts_003_audit_ledger_e2e_test.dart' as ts_003_audit_ledger_e2e_test;
import 'ts_102_governance_e2e_test.dart' as ts_102_governance_e2e_test;
import 'ts_103_rules_viewer_e2e_test.dart' as ts_103_rules_viewer_e2e_test;
import 'ts_201_members_e2e_test.dart' as ts_201_members_e2e_test;
import 'ts_202_shares_e2e_test.dart' as ts_202_shares_e2e_test;
import 'ts_203_risk_controls_e2e_test.dart' as ts_203_risk_controls_e2e_test;
import 'ts_204_membership_changes_e2e_test.dart'
    as ts_204_membership_changes_e2e_test;
import 'ts_301_contributions_e2e_test.dart' as ts_301_contributions_e2e_test;
import 'ts_302_payments_e2e_test.dart' as ts_302_payments_e2e_test;

void main() {
  ts_101_setup_wizard_e2e_test.main();
  patrol_smoke_test.main();
  patrol_e2e_test.main();
  ts_002_components_gallery_e2e_test.main();
  ts_003_audit_ledger_e2e_test.main();
  ts_102_governance_e2e_test.main();
  ts_103_rules_viewer_e2e_test.main();
  ts_201_members_e2e_test.main();
  ts_202_shares_e2e_test.main();
  ts_203_risk_controls_e2e_test.main();
  ts_204_membership_changes_e2e_test.main();
  ts_301_contributions_e2e_test.main();
  ts_302_payments_e2e_test.main();
}
