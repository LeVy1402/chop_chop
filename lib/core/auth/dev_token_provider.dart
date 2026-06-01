import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'token_provider.dart';

class DevTokenProvider implements TokenProvider {
  DevTokenProvider();

  @override
  Future<String?> getToken() async {
    // Read from .env via flutter_dotenv
    return dotenv.env['DEV_TOKEN'];
  }

  @override
  Future<void> saveToken(String token) async {
    // No-op for dev provider
  }

  @override
  Future<void> clearToken() async {
    // No-op
  }
}
