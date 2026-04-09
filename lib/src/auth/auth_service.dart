import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'auth0_config.dart';

enum AuthProvider {
  google('Google'),
  apple('Apple');

  const AuthProvider(this.label);

  final String label;
}

enum AuthFailureReason {
  cancelled,
  unavailable,
  providerNotEnabled,
  configuration,
  unknown,
}

class AuthFailure implements Exception {
  const AuthFailure({
    required this.reason,
    required this.message,
  });

  final AuthFailureReason reason;
  final String message;

  @override
  String toString() => 'AuthFailure($reason): $message';
}

class AuthSession {
  const AuthSession({
    required this.provider,
    this.displayName,
    this.email,
  });

  final AuthProvider provider;
  final String? displayName;
  final String? email;
}

class AuthService {
  const AuthService();

  Future<AuthSession> signIn(AuthProvider provider) async {
    final configError = Auth0Config.validate();
    if (configError != null) {
      throw AuthFailure(
        reason: AuthFailureReason.configuration,
        message: configError,
      );
    }

    final auth0 = Auth0(Auth0Config.domain, Auth0Config.clientId);
    final connection = switch (provider) {
      AuthProvider.google => 'google-oauth2',
      AuthProvider.apple => 'apple',
    };

    try {
      final credentials = await auth0
          .webAuthentication(scheme: Auth0Config.callbackScheme)
          .login(parameters: {'connection': connection});

      final user = credentials.user;
      return AuthSession(
        provider: provider,
        displayName: user.name ?? user.nickname,
        email: user.email,
      );
    } on AuthFailure {
      rethrow;
    } on WebAuthenticationException catch (error) {
      if (error.isUserCancelledException) {
        throw const AuthFailure(
          reason: AuthFailureReason.cancelled,
          message: 'Sign-in was canceled.',
        );
      }

      if (error.code == 'access_denied' || error.code == 'a0.invalid_configuration') {
        throw const AuthFailure(
          reason: AuthFailureReason.providerNotEnabled,
          message: 'Selected provider is not enabled in Auth0. Enable Google/Apple connections in your Auth0 dashboard.',
        );
      }

      throw AuthFailure(
        reason: AuthFailureReason.unknown,
        message: error.message,
      );
    } on MissingPluginException {
      if (kDebugMode) {
        return AuthSession(provider: provider, displayName: 'Local Dev User');
      }

      throw const AuthFailure(
        reason: AuthFailureReason.unavailable,
        message: 'Sign-in provider is not available on this platform build.',
      );
    } catch (_) {
      throw const AuthFailure(
        reason: AuthFailureReason.unknown,
        message: 'Authentication failed unexpectedly. Please try again.',
      );
    }
  }
}
