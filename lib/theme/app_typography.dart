import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.h1Lg,
    required this.h1Md,
    required this.h1Sm,
    required this.h3Lg,
    required this.h3Md,
    required this.h3Sm,
  });

  /// `text-h1-lg`
  ///
  /// - Font size: `45`
  /// - Font weight: `600`
  /// - Line weight: `52`
  /// - Letter spacing: `-0.2`
  final TextStyle h1Lg;

  /// `text-h1-md`
  ///
  /// - Font size: `37`
  /// - Font weight: `w400`
  /// - Line weight: `44`
  /// - Letter spacing: `-0.2`
  final TextStyle h1Md;

  /// `text-h1-sm`
  ///
  /// - Font size: `35`
  /// - Font weight: `w400`
  /// - Line weight: `40`
  /// - Letter spacing: `-0.2`
  final TextStyle h1Sm;

  /// `text-h3-lg`
  ///
  /// - Font size: `31`
  /// - Font weight: `w400`
  /// - Line weight: `36`
  /// - Letter spacing: `-0.2`
  final TextStyle h3Lg;

  /// `text-h3-md`
  ///
  /// - Font size: `23`
  /// - Font weight: `w600`
  /// - Line weight: `28`
  /// - Letter spacing: `-0.2`
  final TextStyle h3Md;

  /// `text-h3-sm`
  ///
  /// - Font size: `19`
  /// - Font weight: `w400`
  /// - Line weight: `24`
  /// - Letter spacing: `-0.2`
  final TextStyle h3Sm;

  @override
  ThemeExtension<AppTypography> copyWith({
    TextStyle? h1Lg,
    TextStyle? h1Md,
    TextStyle? h1Sm,
    TextStyle? h3Lg,
    TextStyle? h3Md,
    TextStyle? h3Sm,
  }) => AppTypography(
    h1Lg: h1Lg ?? this.h1Lg,
    h1Md: h1Md ?? this.h1Md,
    h1Sm: h1Sm ?? this.h1Sm,
    h3Lg: h3Lg ?? this.h3Lg,
    h3Md: h3Md ?? this.h3Md,
    h3Sm: h3Sm ?? this.h3Sm,
  );

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) {
      return this;
    }
    return AppTypography(
      h1Lg: TextStyle.lerp(h1Lg, other.h1Lg, t) ?? h1Lg,
      h1Md: TextStyle.lerp(h1Md, other.h1Md, t) ?? h1Md,
      h1Sm: TextStyle.lerp(h1Sm, other.h1Sm, t) ?? h1Sm,
      h3Lg: TextStyle.lerp(h3Lg, other.h3Lg, t) ?? h3Lg,
      h3Md: TextStyle.lerp(h3Md, other.h3Md, t) ?? h3Md,
      h3Sm: TextStyle.lerp(h3Sm, other.h3Sm, t) ?? h3Sm,
    );
  }
}

const kAppTypography = AppTypography(
  h1Lg: TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.16,
    debugLabel: 'text-h1-lg',
    fontFamily: appFont,
  ),
  h1Md: TextStyle(
    fontSize: 37,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.2,
    height: 1.16,
  ),
  h1Sm: TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.2,
    height: 1.16,
  ),
  h3Lg: TextStyle(
    fontSize: 31,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.2,
    height: 1.16,
  ),
  h3Md: TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.16,
  ),
  h3Sm: TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.2,
    height: 1.16,
  ),
);

extension AppTypographyExtensions on BuildContext {
  AppTypography get appTypography =>
      Theme.of(this).extension<AppTypography>() ?? kAppTypography;

  TextStyle get h1Lg => appTypography.h1Lg;

  TextStyle get h1Md => appTypography.h1Md;

  TextStyle get h1Sm => appTypography.h1Sm;

  TextStyle get h3Lg => appTypography.h3Lg;

  TextStyle get h3Md => appTypography.h3Md;

  TextStyle get h3Sm => appTypography.h3Sm;
}
