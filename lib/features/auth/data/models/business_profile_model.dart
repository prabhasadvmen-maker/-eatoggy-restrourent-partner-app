/// Data model for Business Profile onboarding screen (Step 1 of 4).
class BusinessProfileModel {
  const BusinessProfileModel({
    required this.headerTitle,
    required this.stepText,
    required this.stepProgress,
    required this.title,
    required this.restaurantNameLabel,
    required this.dummyRestaurantName,
    required this.ownerNameLabel,
    required this.dummyOwnerName,
    required this.businessTypeLabel,
    required this.dummyBusinessType,
    required this.businessTypeOptions,
    required this.phoneLabel,
    required this.countryCode,
    required this.dummyPhone,
    required this.emailLabel,
    required this.dummyEmail,
    required this.addressLabel,
    required this.dummyAddress,
    required this.buttonText,
  });

  final String headerTitle;
  final String stepText;
  final double stepProgress;
  final String title;
  final String restaurantNameLabel;
  final String dummyRestaurantName;
  final String ownerNameLabel;
  final String dummyOwnerName;
  final String businessTypeLabel;
  final String dummyBusinessType;
  final List<String> businessTypeOptions;
  final String phoneLabel;
  final String countryCode;
  final String dummyPhone;
  final String emailLabel;
  final String dummyEmail;
  final String addressLabel;
  final String dummyAddress;
  final String buttonText;

  /// Default dummy data matching the Business Profile screen UI mockup.
  static const dummy = BusinessProfileModel(
    headerTitle: 'Business Profile',
    stepText: 'Step 1 of 4',
    stepProgress: 0.25,
    title: 'Basic Details',
    restaurantNameLabel: 'Restaurant / Kitchen Name',
    dummyRestaurantName: 'The Golden Spoon Kitchen',
    ownerNameLabel: 'Owner Full Name',
    dummyOwnerName: 'Aditya Sen',
    businessTypeLabel: 'Business Type',
    dummyBusinessType: 'Cloud Kitchen',
    businessTypeOptions: [
      'Cloud Kitchen',
      'Fine Dining',
      'Quick Service Restaurant (QSR)',
      'Bakery',
      'Food Truck',
      'Cafe',
    ],
    phoneLabel: 'Primary Phone Number',
    countryCode: '+91',
    dummyPhone: '98765 43210',
    emailLabel: 'Email Address',
    dummyEmail: 'aditya@goldenspoon.com',
    addressLabel: 'Full Address',
    dummyAddress: 'Flat 402, Signature Heights, Sector 62, Noida - 201301',
    buttonText: 'Continue',
  );

  BusinessProfileModel copyWith({
    String? headerTitle,
    String? stepText,
    double? stepProgress,
    String? title,
    String? restaurantNameLabel,
    String? dummyRestaurantName,
    String? ownerNameLabel,
    String? dummyOwnerName,
    String? businessTypeLabel,
    String? dummyBusinessType,
    List<String>? businessTypeOptions,
    String? phoneLabel,
    String? countryCode,
    String? dummyPhone,
    String? emailLabel,
    String? dummyEmail,
    String? addressLabel,
    String? dummyAddress,
    String? buttonText,
  }) {
    return BusinessProfileModel(
      headerTitle: headerTitle ?? this.headerTitle,
      stepText: stepText ?? this.stepText,
      stepProgress: stepProgress ?? this.stepProgress,
      title: title ?? this.title,
      restaurantNameLabel: restaurantNameLabel ?? this.restaurantNameLabel,
      dummyRestaurantName: dummyRestaurantName ?? this.dummyRestaurantName,
      ownerNameLabel: ownerNameLabel ?? this.ownerNameLabel,
      dummyOwnerName: dummyOwnerName ?? this.dummyOwnerName,
      businessTypeLabel: businessTypeLabel ?? this.businessTypeLabel,
      dummyBusinessType: dummyBusinessType ?? this.dummyBusinessType,
      businessTypeOptions: businessTypeOptions ?? this.businessTypeOptions,
      phoneLabel: phoneLabel ?? this.phoneLabel,
      countryCode: countryCode ?? this.countryCode,
      dummyPhone: dummyPhone ?? this.dummyPhone,
      emailLabel: emailLabel ?? this.emailLabel,
      dummyEmail: dummyEmail ?? this.dummyEmail,
      addressLabel: addressLabel ?? this.addressLabel,
      dummyAddress: dummyAddress ?? this.dummyAddress,
      buttonText: buttonText ?? this.buttonText,
    );
  }
}
