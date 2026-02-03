import 'patrol_e2e_test.dart' as patrol_e2e_test;
import 'patrol_smoke_test.dart' as patrol_smoke_test;
import 'ts_101_setup_wizard_e2e_test.dart' as ts_101_setup_wizard_e2e_test;
import 'ts_002_components_gallery_e2e_test.dart' as ts_002_components_gallery_e2e_test;
import 'ts_003_audit_ledger_e2e_test.dart' as ts_003_audit_ledger_e2e_test;
import 'ts_102_governance_e2e_test.dart' as ts_102_governance_e2e_test;

void main() {
  ts_101_setup_wizard_e2e_test.main();
  patrol_smoke_test.main();
  patrol_e2e_test.main();
  ts_002_components_gallery_e2e_test.main();
  ts_003_audit_ledger_e2e_test.main();
  ts_102_governance_e2e_test.main();
}
