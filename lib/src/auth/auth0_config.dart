abstract final class Auth0Config {
  // Provide via --dart-define for local/dev use.
  static const domain = String.fromEnvironment(
    'OSTRACK_AUTH0_DOMAIN',
    defaultValue: 'REPLACE_ME.us.auth0.com',
  );
  static const clientId = String.fromEnvironment(
    'OSTRACK_AUTH0_CLIENT_ID',
    defaultValue: 'REPLACE_ME_CLIENT_ID',
  );

  // Must match the scheme in Auth0 Allowed Callback URLs and native config.
  static const callbackScheme = 'com.ostrack.ostrackapp';

  static String? validate() {
    if (domain.contains('REPLACE_ME') || clientId.contains('REPLACE_ME')) {
      return 'Auth0 is not configured. Provide OSTRACK_AUTH0_DOMAIN and OSTRACK_AUTH0_CLIENT_ID via --dart-define.';
    }

    if (callbackScheme.contains('REPLACE_ME')) {
      return 'Auth0 callbackScheme is not configured in lib/src/auth/auth0_config.dart.';
    }

    return null;
  }
}