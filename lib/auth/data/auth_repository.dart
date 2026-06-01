import 'package:http/http.dart' as http;

import '../../core/config/app_config.dart';

class AuthRepository {
  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}/auth/login'),
      body: {'email': email, 'password': password},
    );
    return response.body;
  }
}
