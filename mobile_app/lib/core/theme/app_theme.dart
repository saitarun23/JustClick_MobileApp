import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.background,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.ink,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );

    // Round, friendly font for the whole app.
    return base.copyWith(
      textTheme: GoogleFonts.fredokaTextTheme(base.textTheme).apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
    );
  }
}

class AppText {
  /// Big headline style used across the app.
  static TextStyle display(double size, {Color color = AppColors.ink}) {
    return GoogleFonts.fredoka(
      fontSize: size,
      fontWeight: FontWeight.w700,
      height: 1.1,
      color: color,
    );
  }
}

/// "Sticker" look: thick outline plus a hard offset shadow.
class AppDeco {
  static BoxDecoration sticker({
    Color color = Colors.white,
    double radius = 22,
    double shadow = 4,
    Color shadowColor = AppColors.ink,
    double border = 2.2,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: AppColors.ink, width: border),
      boxShadow: [BoxShadow(color: shadowColor, offset: Offset(shadow, shadow))],
    );
  }

  static BoxDecoration circle({
    Color color = Colors.white,
    double shadow = 3,
    double border = 2.2,
  }) {
    return BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.ink, width: border),
      boxShadow: [BoxShadow(color: AppColors.ink, offset: Offset(shadow, shadow))],
    );
  }
}