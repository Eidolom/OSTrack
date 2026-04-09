import 'package:flutter/material.dart';

import 'ostrack_shell.dart';
import 'ostrack_theme.dart';

class OstrackApp extends StatelessWidget {
  const OstrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSTrack',
      debugShowCheckedModeBanner: false,
      theme: buildOstrackTheme(),
      home: const OstrackShell(),
    );
  }
}
