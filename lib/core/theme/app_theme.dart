import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.goldFont,
      scaffoldBackgroundColor: AppColors.darkBackground,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.goldFont,
        secondary: AppColors.accentYellow,
        surface: AppColors.darkSurface,
        error: AppColors.error,
        onPrimary: AppColors.darkBackground,
        onSecondary: AppColors.darkBackground,
        onSurface: AppColors.textPrimary,
        onError: AppColors.textLight,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.goldFont),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.goldFont,
          foregroundColor: AppColors.darkBackground,
          minimumSize: const Size(double.infinity, AppDimensions.buttonHeight),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderMd),
          elevation: 0,
        ),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: BorderSide(color: AppColors.goldFont, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: BorderSide(color: AppColors.error),
        ),
      ),

      cardTheme: const CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderMd,
          side: BorderSide(color: AppColors.darkBorder, width: 0.8),
        ),
        margin: EdgeInsets.zero,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBackground,
        selectedItemColor: AppColors.goldFont,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }

  // Backward compatibility alias for lightTheme targeting dark
  static ThemeData get lightTheme => darkTheme;
}
