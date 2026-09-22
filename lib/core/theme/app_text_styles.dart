import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  // ─── Title (18.sp) ────────────────────────────────────────────────────────
  static TextStyle get title => GoogleFonts.outfit(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
        height: 1.3,
      );

  static TextStyle get titleMedium => GoogleFonts.outfit(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get titleWhite => GoogleFonts.outfit(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textOnPrimary,
        height: 1.3,
      );

  // ─── Heading (17.sp) ──────────────────────────────────────────────────────
  static TextStyle get heading => GoogleFonts.outfit(
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get headingMedium => GoogleFonts.outfit(
        fontSize: 17.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get headingWhite => GoogleFonts.outfit(
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textOnPrimary,
        height: 1.3,
      );

  // ─── Sub Heading (16.sp) ──────────────────────────────────────────────────
  static TextStyle get subhead => GoogleFonts.outfit(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get subheadMedium => GoogleFonts.outfit(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get subheadSecondary => GoogleFonts.outfit(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  // ─── Body (15.sp) ─────────────────────────────────────────────────────────
  static TextStyle get body => GoogleFonts.outfit(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.outfit(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodySemiBold => GoogleFonts.outfit(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodySecondary => GoogleFonts.outfit(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get bodyWhite => GoogleFonts.outfit(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textOnPrimary,
        height: 1.5,
      );

  // ─── Caption (14.sp) ──────────────────────────────────────────────────────
  static TextStyle get caption => GoogleFonts.outfit(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get captionMedium => GoogleFonts.outfit(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get captionPrimary => GoogleFonts.outfit(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
        height: 1.4,
      );

  static TextStyle get captionWhite => GoogleFonts.outfit(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textOnPrimary,
        height: 1.4,
      );

  static TextStyle get captionError => GoogleFonts.outfit(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.error,
        height: 1.4,
      );

  // ─── Button ───────────────────────────────────────────────────────────────
  static TextStyle get buttonLarge => GoogleFonts.outfit(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textOnPrimary,
        letterSpacing: 0.3,
      );

  static TextStyle get buttonMedium => GoogleFonts.outfit(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textOnPrimary,
        letterSpacing: 0.3,
      );

  // ─── Label ────────────────────────────────────────────────────────────────
  static TextStyle get label => GoogleFonts.outfit(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.3,
      );

  static TextStyle get labelSecondary => GoogleFonts.outfit(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.3,
      );

  // ─── Hint (15.sp) ──────────────────────────────────────────────────────────
  static TextStyle get hint => GoogleFonts.outfit(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
        height: 1.5,
      );
}
