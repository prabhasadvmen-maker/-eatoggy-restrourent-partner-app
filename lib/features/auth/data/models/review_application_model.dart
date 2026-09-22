class ReviewApplicationModel {
  const ReviewApplicationModel({
    required this.screenTitle,
    required this.stepText,
    required this.headingText,
    required this.businessTitle,
    required this.restaurantName,
    required this.businessSubtext,
    required this.documentsTitle,
    required this.documentsList,
    required this.bankTitle,
    required this.bankInfo,
    required this.feeTitle,
    required this.feeSubtext,
    required this.feeAmount,
    required this.buttonText,
  });

  final String screenTitle;
  final String stepText;
  final String headingText;
  final String businessTitle;
  final String restaurantName;
  final String businessSubtext;
  final String documentsTitle;
  final List<String> documentsList;
  final String bankTitle;
  final String bankInfo;
  final String feeTitle;
  final String feeSubtext;
  final String feeAmount;
  final String buttonText;

  static const dummy = ReviewApplicationModel(
    screenTitle: 'Review Details',
    stepText: 'Step 4 of 4',
    headingText: 'Review Your Application',
    businessTitle: 'Business Details',
    restaurantName: 'The Golden Spoon Kitchen',
    businessSubtext: 'Cloud Kitchen • Sector 62, Noida',
    documentsTitle: 'Uploaded Documents',
    documentsList: ['GST Certificate', 'FSSAI License', 'Aadhaar Card'],
    bankTitle: 'Bank Account',
    bankInfo: 'State Bank of India • Ending in 4321',
    feeTitle: 'One-time Setup Fee',
    feeSubtext: 'Includes startup kit & photoshoot',
    feeAmount: '₹999',
    buttonText: 'Pay & Submit Application',
  );
}
