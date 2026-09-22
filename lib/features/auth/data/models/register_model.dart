import 'package:flutter/material.dart';

/// Single feature item model for partner onboarding benefits.
class RegisterFeatureItem {
  const RegisterFeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}

/// Data model for Partner Registration / Welcome screen.
class RegisterModel {
  const RegisterModel({
    required this.titlePrefix,
    required this.brandName,
    required this.titleSuffix,
    required this.subtitle,
    required this.heroImageAsset,
    required this.features,
    required this.buttonText,
    required this.loginPrefix,
    required this.loginAction,
  });

  final String titlePrefix;
  final String brandName;
  final String titleSuffix;
  final String subtitle;
  final String heroImageAsset;
  final List<RegisterFeatureItem> features;
  final String buttonText;
  final String loginPrefix;
  final String loginAction;

  /// Default dummy data matching the Partner Registration screen UI mockup.
  static const dummy = RegisterModel(
    titlePrefix: 'Welcome to ',
    brandName: 'EATOGGY',
    titleSuffix: ' Partner',
    subtitle:
        'Register your kitchen in under 10 minutes and start selling to thousands of hungry food lovers.',
    heroImageAsset: 'assets/images/register.png',
    features: [
      RegisterFeatureItem(
        icon: Icons.show_chart_rounded,
        title: 'Reach More Customers',
        subtitle: 'Instantly unlock delivery to a 10km radius.',
      ),
      RegisterFeatureItem(
        icon: Icons.pie_chart_outline_rounded,
        title: 'Manage Orders Easily',
        subtitle: 'Super smooth partner dashboard & auto-assigned riders.',
      ),
      RegisterFeatureItem(
        icon: Icons.workspace_premium_outlined,
        title: 'Grow Your Brand',
        subtitle: 'Run custom discount campaigns to boost sales by 40%.',
      ),
    ],
    buttonText: 'Start Registration',
    loginPrefix: 'Already have an account?',
    loginAction: 'Login',
  );

  RegisterModel copyWith({
    String? titlePrefix,
    String? brandName,
    String? titleSuffix,
    String? subtitle,
    String? heroImageAsset,
    List<RegisterFeatureItem>? features,
    String? buttonText,
    String? loginPrefix,
    String? loginAction,
  }) {
    return RegisterModel(
      titlePrefix: titlePrefix ?? this.titlePrefix,
      brandName: brandName ?? this.brandName,
      titleSuffix: titleSuffix ?? this.titleSuffix,
      subtitle: subtitle ?? this.subtitle,
      heroImageAsset: heroImageAsset ?? this.heroImageAsset,
      features: features ?? this.features,
      buttonText: buttonText ?? this.buttonText,
      loginPrefix: loginPrefix ?? this.loginPrefix,
      loginAction: loginAction ?? this.loginAction,
    );
  }
}
