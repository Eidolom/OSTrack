enum AuthProvider {
  google('Google'),
  apple('Apple'),
  email('Email');

  const AuthProvider(this.label);

  final String label;
}

class AuthService {
  const AuthService();

  Future<void> signIn(AuthProvider provider) async {
    // Stubbed auth path for foundation phase. Replace with real SDK integrations.
    await Future<void>.delayed(const Duration(milliseconds: 160));
  }
}
