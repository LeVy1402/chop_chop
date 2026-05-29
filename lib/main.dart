import 'package:chop_chop/categories/presentation/pages/menu_page.dart';
import 'package:chop_chop/theme/app_colors.dart';
import 'package:chop_chop/theme/app_typography.dart';
import 'package:chop_chop/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
