import '../entities/export_result.dart';

abstract interface class PlatformShareGateway {
  Future<void> shareFile({
    required ExportResult export,
    required String text,
  });
}

