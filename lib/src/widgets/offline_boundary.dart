import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../ostrack_theme.dart';

class OfflineBoundary extends StatelessWidget {
  const OfflineBoundary({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final isOffline = snapshot.hasData && 
            snapshot.data == ConnectivityResult.none;

        return Stack(
          children: [
            child,
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: isOffline ? 0 : -50,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Material(
                  color: OstrackColors.coral.withAlpha((0.9 * 255).toInt()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      'Offline mode. Browsing local cache.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
