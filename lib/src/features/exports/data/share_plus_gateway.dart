import 'package:share_plus/share_plus.dart';

import '../domain/entities/export_result.dart';
import '../domain/gateways/platform_share_gateway.dart';

final class SharePlusGateway implements PlatformShareGateway {
  @override
  Future<void> shareFile({
    required ExportResult export,
    required String text,
  }) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile(
            export.filePath,
            mimeType: export.mimeType,
            name: export.fileName,
          ),
        ],
        text: text,
      ),
    );
  }
}
