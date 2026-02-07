import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/export_result.dart';
import '../gateways/platform_share_gateway.dart';
import 'export_exceptions.dart';

class ShareExport {
  const ShareExport({
    required PlatformShareGateway shareGateway,
    required AppendAuditEvent appendAuditEvent,
  })  : _shareGateway = shareGateway,
        _appendAuditEvent = appendAuditEvent;

  final PlatformShareGateway _shareGateway;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required ExportResult export,
    required String consentReference,
    required DateTime now,
  }) async {
    if (consentReference.trim().isEmpty) {
      throw const ExportException('Consent reference is required to share.');
    }

    await _shareGateway.shareFile(
      export: export,
      text: 'Tan Shomiti export: ${export.fileName}',
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'export_shared',
        occurredAt: now,
        message: 'Shared export file.',
        metadataJson: jsonEncode({
          'fileName': export.fileName,
          'consentReference': consentReference.trim(),
        }),
      ),
    );
  }
}

