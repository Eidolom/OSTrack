import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'src/backend/backend_config.dart';
import 'src/backend/cache_models.dart';
import 'src/backend/local_cache/cache_models.dart' as local_cache;
import 'src/ostrack_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (BackendConfig.hasSupabase) {
      await Supabase.initialize(
        url: BackendConfig.supabaseUrl,
        anonKey: BackendConfig.supabaseAnonKey,
      );
    }

    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        IsarCategoryEntrySchema,
        IsarTrendEntrySchema,
        IsarActiveTrackEntrySchema,
        IsarMascotEntrySchema,
        IsarProfileEntrySchema,
        IsarMediaSearchResultSchema,
        IsarShelfSchema,
        IsarShelfTrackSchema,
        IsarTrackRatingSchema,
        IsarPendingMutationSchema,
        local_cache.CachedFeedStorySchema,
      ],
      directory: dir.path,
    );

    runApp(OstrackApp(isar: isar));
  } catch (error) {
    runApp(_BootFailureApp(error: error.toString()));
  }
}

class _BootFailureApp extends StatelessWidget {
  const _BootFailureApp({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0F0F12),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.redAccent, size: 42),
                  const SizedBox(height: 12),
                  const Text(
                    'OSTrack could not start local storage.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xFFB2B4BA), fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
