import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database_provider.dart';
import 'reset_app_data.dart';

final resetAppDataProvider = Provider<ResetAppData>((ref) {
  return ResetAppData(ref.watch(appDatabaseProvider));
});

