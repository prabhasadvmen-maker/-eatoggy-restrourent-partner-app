class IdentityBankModel {
  const IdentityBankModel({
    required this.screenTitle,
    required this.stepText,
    required this.headingText,
    required this.aadhaarTitle,
    required this.aadhaarRequired,
    required this.aadhaarUploadNote,
    required this.bankDetailsHeading,
    required this.accountHolderLabel,
    required this.accountHolderHint,
    required this.accountNumberLabel,
    required this.accountNumberHint,
    required this.ifscLabel,
    required this.ifscHint,
    required this.bankNameLabel,
    required this.bankNameHint,
    required this.buttonText,
  });

  final String screenTitle;
  final String stepText;
  final String headingText;
  final String aadhaarTitle;
  final bool aadhaarRequired;
  final String aadhaarUploadNote;
  final String bankDetailsHeading;
  final String accountHolderLabel;
  final String accountHolderHint;
  final String accountNumberLabel;
  final String accountNumberHint;
  final String ifscLabel;
  final String ifscHint;
  final String bankNameLabel;
  final String bankNameHint;
  final String buttonText;

  static const dummy = IdentityBankModel(
    screenTitle: 'Identity & Bank',
    stepText: 'Step 3 of 4',
    headingText: 'Identity & Payout Details',
    aadhaarTitle: 'Aadhaar Card (Front & Back)',
    aadhaarRequired: true,
    aadhaarUploadNote: 'Max 5MB • PDF, JPG',
    bankDetailsHeading: 'Bank Details',
    accountHolderLabel: 'Account Holder Name',
    accountHolderHint: 'Aditya Sen',
    accountNumberLabel: 'Bank Account Number',
    accountNumberHint: 'Enter bank account number',
    ifscLabel: 'IFSC Code',
    ifscHint: 'SBIN0001234',
    bankNameLabel: 'Bank Name',
    bankNameHint: 'State Bank of India',
    buttonText: 'Continue',
  );
}
