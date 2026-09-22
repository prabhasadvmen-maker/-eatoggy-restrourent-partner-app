/// Data model for OTP Verification screen containing labels, texts, and dummy defaults.
class OtpModel {
  const OtpModel({
    required this.headerTitle,
    required this.title,
    required this.subtitlePrefix,
    required this.defaultCountryCode,
    required this.dummyPhoneNumber,
    required this.dummyOtpDigits,
    required this.otpLength,
    required this.resendPrefix,
    required this.resendTimerText,
    required this.resendActionText,
    required this.buttonText,
  });

  final String headerTitle;
  final String title;
  final String subtitlePrefix;
  final String defaultCountryCode;
  final String dummyPhoneNumber;
  final List<String> dummyOtpDigits;
  final int otpLength;
  final String resendPrefix;
  final String resendTimerText;
  final String resendActionText;
  final String buttonText;

  /// Default dummy data matching the OTP screen UI mockup.
  static const dummy = OtpModel(
    headerTitle: 'Verify Details',
    title: 'Enter OTP',
    subtitlePrefix: 'Sent to ',
    defaultCountryCode: '+91 ',
    dummyPhoneNumber: '98765 43210',
    dummyOtpDigits: ['', '', '', ''],
    otpLength: 4,
    resendPrefix: 'Didn\'t receive code?',
    resendTimerText: 'Resend in ',
    resendActionText: 'Resend OTP',
    buttonText: 'Verify OTP',
  );

  OtpModel copyWith({
    String? headerTitle,
    String? title,
    String? subtitlePrefix,
    String? defaultCountryCode,
    String? dummyPhoneNumber,
    List<String>? dummyOtpDigits,
    int? otpLength,
    String? resendPrefix,
    String? resendTimerText,
    String? resendActionText,
    String? buttonText,
  }) {
    return OtpModel(
      headerTitle: headerTitle ?? this.headerTitle,
      title: title ?? this.title,
      subtitlePrefix: subtitlePrefix ?? this.subtitlePrefix,
      defaultCountryCode: defaultCountryCode ?? this.defaultCountryCode,
      dummyPhoneNumber: dummyPhoneNumber ?? this.dummyPhoneNumber,
      dummyOtpDigits: dummyOtpDigits ?? this.dummyOtpDigits,
      otpLength: otpLength ?? this.otpLength,
      resendPrefix: resendPrefix ?? this.resendPrefix,
      resendTimerText: resendTimerText ?? this.resendTimerText,
      resendActionText: resendActionText ?? this.resendActionText,
      buttonText: buttonText ?? this.buttonText,
    );
  }
}
