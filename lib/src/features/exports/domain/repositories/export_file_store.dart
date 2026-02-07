abstract interface class ExportFileStore {
  Future<ExportStoredFile> writeText({
    required String fileName,
    required String contents,
    required String mimeType,
  });
}

class ExportStoredFile {
  const ExportStoredFile({
    required this.path,
    required this.fileName,
    required this.mimeType,
  });

  final String path;
  final String fileName;
  final String mimeType;
}

