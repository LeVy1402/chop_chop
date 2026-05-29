import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({required this.primary, required this.background});

  final ColorSwatch<int> primary;
  final ColorSwatch<int> background;

  @override
  ThemeExtension<AppColors> copyWith({
    ColorSwatch<int>? primary,
    ColorSwatch<int>? background,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primary: ColorSwatch.lerp(primary, other.primary, t) ?? primary,
      background:
          ColorSwatch.lerp(background, other.background, t) ?? background,
    );
  }
}

const kAppColors = AppColors(
  primary: ColorSwatch(0xffFF6C01, {}),
  background: ColorSwatch(0xffFAFAFA, {}),
);

extension AppColorExtensions on BuildContext {
  AppColors get appColors =>
      Theme.of(this).extension<AppColors>() ?? kAppColors;

  ColorSwatch<int> get primary => appColors.primary;

  ColorSwatch<int> get background => appColors.background;
}
