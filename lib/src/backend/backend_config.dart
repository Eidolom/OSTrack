class BackendConfig {
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static const typesenseHost = String.fromEnvironment('TYPESENSE_HOST');
  static const typesensePort = String.fromEnvironment('TYPESENSE_PORT', defaultValue: '8108');
  static const typesenseProtocol = String.fromEnvironment('TYPESENSE_PROTOCOL', defaultValue: 'https');
  static const typesenseSearchApiKey = String.fromEnvironment('TYPESENSE_SEARCH_API_KEY');
  static const typesenseConnectionTimeoutMs = int.fromEnvironment('TYPESENSE_CONNECTION_TIMEOUT_MS', defaultValue: 8000);

  static bool get hasSupabase => supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

  static bool get hasTypesense => typesenseHost.isNotEmpty && typesenseSearchApiKey.isNotEmpty;
}
