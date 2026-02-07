import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../ledger/presentation/providers/ledger_providers.dart';
import '../../../statements/presentation/providers/statements_domain_providers.dart';
import '../../data/io_export_file_store.dart';
import '../../data/share_plus_gateway.dart';
import '../../domain/gateways/platform_share_gateway.dart';
import '../../domain/repositories/export_file_store.dart';
import '../../domain/usecases/generate_ledger_export.dart';
import '../../domain/usecases/generate_statement_export.dart';
import '../../domain/usecases/share_export.dart';

final exportFileStoreProvider = Provider<ExportFileStore>((ref) {
  return IoExportFileStore(
    baseDir: () async {
      // Use application support dir for stable, user-backed storage.
      final dir = await getApplicationSupportDirectory();
      return Directory(dir.path);
    },
  );
});

final platformShareGatewayProvider = Provider<PlatformShareGateway>((ref) {
  return SharePlusGateway();
});

final generateStatementExportProvider = Provider<GenerateStatementExport>((ref) {
  return GenerateStatementExport(
    statementsRepository: ref.watch(statementsRepositoryProvider),
    fileStore: ref.watch(exportFileStoreProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final generateLedgerExportProvider = Provider<GenerateLedgerExport>((ref) {
  return GenerateLedgerExport(
    ledgerRepository: ref.watch(ledgerRepositoryProvider),
    fileStore: ref.watch(exportFileStoreProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final shareExportProvider = Provider<ShareExport>((ref) {
  return ShareExport(
    shareGateway: ref.watch(platformShareGatewayProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});
