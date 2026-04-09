import 'package:flutter/material.dart';

import 'ostrack_catalog.dart';
import 'onboarding/onboarding_flow.dart';
import 'ostrack_theme.dart';

class OstrackApp extends StatelessWidget {
  const OstrackApp({super.key, this.catalog = const OstrackCatalog()});

  final OstrackCatalog catalog;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSTrack',
      debugShowCheckedModeBanner: false,
      theme: buildOstrackTheme(),
      home: OnboardingFlow(catalog: catalog),
    );
  }
}
