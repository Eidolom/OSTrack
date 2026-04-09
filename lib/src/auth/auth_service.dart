import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AuthProvider {
  google('Google'),
  apple('Apple');

  const AuthProvider(this.label);

  final String label;
}

enum AuthFailureReason {
  cancelled,
  unavailable,
  invalidCredential,
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
    try {
      switch (provider) {
        case AuthProvider.google:
          return _signInWithGoogle();
        case AuthProvider.apple:
          return _signInWithApple();
      }
    } on AuthFailure {
      rethrow;
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

  Future<AuthSession> _signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      scopes: const ['email'],
    );
    final account = await googleSignIn.signIn();

    if (account == null) {
      throw const AuthFailure(
        reason: AuthFailureReason.cancelled,
        message: 'Google sign-in was canceled.',
      );
    }

    return AuthSession(
      provider: AuthProvider.google,
      displayName: account.displayName,
      email: account.email,
    );
  }

  Future<AuthSession> _signInWithApple() async {
    final available = await SignInWithApple.isAvailable();
    if (!available) {
      throw const AuthFailure(
        reason: AuthFailureReason.unavailable,
        message: 'Apple sign-in is not available on this device.',
      );
    }

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: const [AppleIDAuthorizationScopes.email],
    );

    if (credential.identityToken == null || credential.identityToken!.isEmpty) {
      throw const AuthFailure(
        reason: AuthFailureReason.invalidCredential,
        message: 'Apple sign-in returned an invalid identity token.',
      );
    }

    final displayName = [credential.givenName, credential.familyName]
        .where((part) => part != null && part!.trim().isNotEmpty)
        .map((part) => part!.trim())
        .join(' ');

    return AuthSession(
      provider: AuthProvider.apple,
      displayName: displayName.isEmpty ? null : displayName,
      email: credential.email,
    );
  }
}
