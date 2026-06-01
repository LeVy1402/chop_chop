import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get baseUrl => dotenv.env['BASE_URL']!;

  static String get devEmail => dotenv.env['DEV_EMAIL']!;

  static String get devPassword => dotenv.env['DEV_PASSWORD']!;
}
