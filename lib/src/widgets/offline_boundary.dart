import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../ostrack_theme.dart';

class OfflineBoundary extends StatefulWidget {
  const OfflineBoundary({super.key, required this.child});
  final Widget child;

  @override
  State<OfflineBoundary> createState() => _OfflineBoundaryState();
}

class _OfflineBoundaryState extends State<OfflineBoundary> {
  StreamSubscription<dynamic>? _connectivitySubscription;
  StreamSubscription<InternetStatus>? _internetSubscription;

  bool _hasActiveInterface = true;
  bool _hasInternetAccess = true;

  @override
  void initState() {
    super.initState();
    _initializeStatus();

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((dynamic result) {
      final hasInterface = _containsActiveInterface(result);
      if (!mounted) {
        return;
      }
      setState(() {
        _hasActiveInterface = hasInterface;
      });
      if (!hasInterface) {
        setState(() {
          _hasInternetAccess = false;
        });
      }
    });

    _internetSubscription = InternetConnection().onStatusChange.listen((status) {
      if (!mounted) {
        return;
      }
      setState(() {
        _hasInternetAccess = status == InternetStatus.connected;
      });
    });
  }

  Future<void> _initializeStatus() async {
    final dynamic connectivityResult = await Connectivity().checkConnectivity();
    final hasInterface = _containsActiveInterface(connectivityResult);
    final hasInternet = await InternetConnection().hasInternetAccess;

    if (!mounted) {
      return;
    }

    setState(() {
      _hasActiveInterface = hasInterface;
      _hasInternetAccess = hasInternet;
    });
  }

  bool _containsActiveInterface(dynamic connectivityResult) {
    if (connectivityResult is List<ConnectivityResult>) {
      return connectivityResult.any((result) => result != ConnectivityResult.none);
    }
    if (connectivityResult is ConnectivityResult) {
      return connectivityResult != ConnectivityResult.none;
    }
    return false;
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _internetSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = !_hasActiveInterface || !_hasInternetAccess;

    return Stack(
      children: [
        widget.child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: IgnorePointer(
            ignoring: !isOffline,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              offset: isOffline ? Offset.zero : const Offset(0, -1),
              child: SafeArea(
                child: Material(
                  color: OstrackColors.coral.withValues(alpha: 0.9),
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
          ),
        ),
      ],
    );
  }
}
