import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Backgrounds & Surfaces
  static const Color darkBackground = Color(0xFF11110F);
  static const Color splashBackground = Color(0xFF11110F);
  static const Color darkSurface = Color(0xFF1C1C1A);
  static const Color darkCard = Color(0xFF1E1E1C);
  static const Color darkBorder = Color(0xFF2E2E2A);
  static const Color background = Color(0xFF11110F);
  static const Color surface = Color(0xFF1C1C1A);
  static const Color surfaceVariant = Color(0xFF252522);

  // Primary & Accents
  static const Color primary = Color(0xFFD9A24F);
  static const Color primaryDark = Color(0xFFB58338);
  static const Color primaryLight = Color(0xFF2E2A20);
  static const Color goldFont = Color(0xFFD9A24F);
  static const Color goldGradientStart = Color(0xFFE5B563);
  static const Color goldGradientEnd = Color(0xFFC78B38);
  static const Color cardGoldAccent = Color(0xFFE5A64E);
  static const Color creamText = Color(0xFFFFF1D2);
  static const Color accentYellow = Color(0xFFFFB800);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFE5B563), Color(0xFFC78B38)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Colors
  static const Color textPrimary = Color(0xFFD9A24F);
  static const Color textSecondary = Color(0xFFFFF1D2);
  static const Color textMuted = Color(0xFF7A7A77);
  static const Color textHint = Color(0xFF7A7A77);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textGold = Color(0xFFD9A24F);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB3B3B0);
  static const Color textMutedDark = Color(0xFF7A7A77);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF388E3C);
  static const Color successLight = Color(0xFF1E3A20);
  static const Color warning = Color(0xFFED6C02);
  static const Color warningLight = Color(0xFF3D2B10);
  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFF3E1A1A);
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF1A2A3E);

  // Veg / Non-Veg
  static const Color veg = Color(0xFF388E3C);
  static const Color vegLight = Color(0xFF1E3A20);
  static const Color nonVeg = Color(0xFFE53935);
  static const Color nonVegLight = Color(0xFF3E1A1A);

  // Order Status Colors
  static const Color orderNew = Color(0xFF2196F3);
  static const Color orderNewLight = Color(0xFF1A2A3E);
  static const Color orderActive = Color(0xFFFF9800);
  static const Color orderActiveLight = Color(0xFF3D2B10);
  static const Color orderReady = Color(0xFF4CAF50);
  static const Color orderReadyLight = Color(0xFF1E3A20);
  static const Color orderDelivered = Color(0xFF388E3C);
  static const Color orderDeliveredLight = Color(0xFF1E3A20);
  static const Color orderCancelled = Color(0xFFE53935);
  static const Color orderCancelledLight = Color(0xFF3E1A1A);

  // Borders & Utility
  static const Color border = Color(0xFF2E2E2A);
  static const Color borderDark = Color(0xFF3A3A35);
  static const Color borderFocused = Color(0xFFD9A24F);
  static const Color divider = Color(0xFF262623);
  static const Color shadow = Color(0x40000000);
  static const Color overlay = Color(0x99000000);
}
