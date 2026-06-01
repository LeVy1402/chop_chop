import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'categories/presentation/pages/menu_page.dart';
import 'core/boostrap/auth_boostrap.dart';
import 'core/di/service_locator.dart';
import 'theme/app_colors.dart';
import 'theme/app_typography.dart';
import 'utils/constants.dart';
import 'auth/data/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Setup DI
  await setupServiceLocator();

  // Auth bootstrap
  await AuthBootstrapper(getIt<AuthRepository>()).init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chop Chop',
      theme: ThemeData(
        extensions: [kAppColors, kAppTypography],
        fontFamily: appFont,
      ),
      home: const MenuPage(),
    );
  }
}
