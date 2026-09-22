/// Data model for Partner Login screen containing text labels, titles, and dummy values.
class LoginModel {
  const LoginModel({
    required this.brandName,
    required this.brandLogo,
    required this.title,
    required this.subtitle,
    required this.phoneInputLabel,
    required this.countryCode,
    required this.dummyPhoneNumber,
    required this.buttonText,
    required this.newRestaurantText,
    required this.registerText,
  });

  final String brandName;
  final String brandLogo;
  final String title;
  final String subtitle;
  final String phoneInputLabel;
  final String countryCode;
  final String dummyPhoneNumber;
  final String buttonText;
  final String newRestaurantText;
  final String registerText;

  /// Default dummy data representing the Partner Login screen content.
  static const dummy = LoginModel(
    brandName: 'EATOGGY',
    brandLogo: 'assets/images/logo.png',
    title: 'Partner Login',
    subtitle: 'Enter your registered mobile number to manage your kitchen',
    phoneInputLabel: 'Enter Mobile Number',
    countryCode: '+91',
    dummyPhoneNumber: '98765 43210',
    buttonText: 'Login with OTP',
    newRestaurantText: 'New restaurant?',
    registerText: 'Register here',
  );

  LoginModel copyWith({
    String? brandName,
    String? brandLogo,
    String? title,
    String? subtitle,
    String? phoneInputLabel,
    String? countryCode,
    String? dummyPhoneNumber,
    String? buttonText,
    String? newRestaurantText,
    String? registerText,
  }) {
    return LoginModel(
      brandName: brandName ?? this.brandName,
      brandLogo: brandLogo ?? this.brandLogo,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      phoneInputLabel: phoneInputLabel ?? this.phoneInputLabel,
      countryCode: countryCode ?? this.countryCode,
      dummyPhoneNumber: dummyPhoneNumber ?? this.dummyPhoneNumber,
      buttonText: buttonText ?? this.buttonText,
      newRestaurantText: newRestaurantText ?? this.newRestaurantText,
      registerText: registerText ?? this.registerText,
    );
  }
}
