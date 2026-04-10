import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'src/backend/backend_config.dart';
import 'src/backend/cache_models.dart';
import 'src/ostrack_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (BackendConfig.hasSupabase) {
    await Supabase.initialize(
      url: BackendConfig.supabaseUrl,
      anonKey: BackendConfig.supabaseAnonKey,
    );
  }

  // Initialize Isar local database
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      isarCategoryEntrySchema,
      isarTrendEntrySchema,
      isarActiveTrackEntrySchema,
      isarMascotEntrySchema,
      isarProfileEntrySchema,
      isarMediaSearchResultSchema,
      isarShelfSchema,
      isarShelfTrackSchema,
      isarTrackRatingSchema,
      isarPendingMutationSchema,
    ],
    directory: dir.path,
  );

  runApp(OstrackApp(isar: isar));
}
