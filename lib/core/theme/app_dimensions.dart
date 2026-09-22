import 'package:flutter/material.dart';

/// Centralized dimension constants for consistent spacing, radius, and sizing.
/// For dynamic responsive values use Sizer (e.g. 2.h, 5.w).
/// This file holds fixed structural constants (border radii, icon sizes, etc.)
abstract class AppDimensions {
  // ─── Border Radius ────────────────────────────────────────────────────────
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusXxl = 24.0;
  static const double radiusFull = 100.0;

  // ─── Icon Sizes ───────────────────────────────────────────────────────────
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 28.0;
  static const double iconXl = 32.0;
  static const double iconXxl = 40.0;

  // ─── Button ───────────────────────────────────────────────────────────────
  static const double buttonHeight = 52.0;
  static const double buttonHeightLg = 52.0;
  static const double buttonHeightMd = 44.0;
  static const double buttonHeightSm = 36.0;

  // ─── Input Field ──────────────────────────────────────────────────────────
  static const double inputHeight = 52.0;
  static const double inputBorderWidth = 1.0;
  static const double inputBorderWidthFocused = 1.5;

  // ─── AppBar ───────────────────────────────────────────────────────────────
  static const double appBarHeight = 56.0;
  static const double appBarElevation = 0.0;

  // ─── Bottom Nav ───────────────────────────────────────────────────────────
  static const double bottomNavHeight = 60.0;

  // ─── Card ─────────────────────────────────────────────────────────────────
  static const double cardElevation = 0.0;
  static const double cardBorderWidth = 1.0;

  // ─── Avatar ───────────────────────────────────────────────────────────────
  static const double avatarSm = 32.0;
  static const double avatarMd = 44.0;
  static const double avatarLg = 60.0;
  static const double avatarXl = 80.0;

  // ─── Divider ──────────────────────────────────────────────────────────────
  static const double dividerThickness = 1.0;

  // ─── OTP Input ────────────────────────────────────────────────────────────
  static const double otpBoxWidth = 46.0;
  static const double otpBoxHeight = 52.0;
}

abstract class AppRadius {
  static const BorderRadius borderXs = BorderRadius.all(Radius.circular(AppDimensions.radiusXs));
  static const BorderRadius borderSm = BorderRadius.all(Radius.circular(AppDimensions.radiusSm));
  static const BorderRadius borderMd = BorderRadius.all(Radius.circular(AppDimensions.radiusMd));
  static const BorderRadius borderLg = BorderRadius.all(Radius.circular(AppDimensions.radiusLg));
  static const BorderRadius borderXl = BorderRadius.all(Radius.circular(AppDimensions.radiusXl));
  static const BorderRadius borderFull = BorderRadius.all(Radius.circular(AppDimensions.radiusFull));
}
