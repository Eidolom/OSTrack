abstract final class Auth0Config {
  // Set these to your tenant/application values.
  static const domain = 'dev-58tp0mtjukekxfr5.eu.auth0.com';
  static const clientId = 'Ezko0w1ouG50TbgwRrZPa4Q3CkUmpFn9';

  // Must match the scheme in Auth0 Allowed Callback URLs and native config.
  static const callbackScheme = 'com.ostrack.ostrackapp';

  static String? validate() {
    if (domain.contains('REPLACE_ME') || clientId.contains('REPLACE_ME')) {
      return 'Auth0 is not configured. Fill domain and clientId in lib/src/auth/auth0_config.dart.';
    }

    if (callbackScheme.contains('REPLACE_ME')) {
      return 'Auth0 callbackScheme is not configured in lib/src/auth/auth0_config.dart.';
    }

    return null;
  }
}