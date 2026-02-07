import 'dart:io';

import 'package:path/path.dart' as p;

import '../domain/repositories/export_file_store.dart';

final class IoExportFileStore implements ExportFileStore {
  IoExportFileStore({required Future<Directory> Function() baseDir})
      : _baseDir = baseDir;

  final Future<Directory> Function() _baseDir;

  @override
  Future<ExportStoredFile> writeText({
    required String fileName,
    required String contents,
    required String mimeType,
  }) async {
    final base = await _baseDir();
    final exportsDir = Directory(p.join(base.path, 'exports'));
    if (!await exportsDir.exists()) {
      await exportsDir.create(recursive: true);
    }

    final safeName = fileName.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
    final file = File(p.join(exportsDir.path, safeName));
    await file.writeAsString(contents);

    return ExportStoredFile(
      path: file.path,
      fileName: safeName,
      mimeType: mimeType,
    );
  }
}

