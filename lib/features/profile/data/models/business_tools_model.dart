class BankAccountModel {
  final String bankName;
  final String accountNumber;
  final String maskedAccountNumber;
  final String ifscCode;
  final String beneficiaryName;
  final String accountType;
  final String branch;
  final bool isVerified;

  const BankAccountModel({
    required this.bankName,
    required this.accountNumber,
    required this.maskedAccountNumber,
    required this.ifscCode,
    required this.beneficiaryName,
    required this.accountType,
    required this.branch,
    this.isVerified = true,
  });

  BankAccountModel copyWith({
    String? bankName,
    String? accountNumber,
    String? maskedAccountNumber,
    String? ifscCode,
    String? beneficiaryName,
    String? accountType,
    String? branch,
    bool? isVerified,
  }) {
    return BankAccountModel(
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      maskedAccountNumber: maskedAccountNumber ?? this.maskedAccountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      beneficiaryName: beneficiaryName ?? this.beneficiaryName,
      accountType: accountType ?? this.accountType,
      branch: branch ?? this.branch,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  static const dummy = BankAccountModel(
        bankName: 'HDFC Bank',
        accountNumber: '50100492817290',
        maskedAccountNumber: '•••• •••• •••• 1234',
        ifscCode: 'HDFC0001234',
        beneficiaryName: 'Harish Kumar',
        accountType: 'Current Account',
        branch: 'HSR Layout, Bangalore',
        isVerified: true,
      );
}

class TaxInformationModel {
  final String legalBusinessName;
  final String gstin;
  final String panNumber;
  final String taxpayerType;
  final String registeredAddress;
  final String stateJurisdiction;
  final bool isVerified;

  const TaxInformationModel({
    required this.legalBusinessName,
    required this.gstin,
    required this.panNumber,
    required this.taxpayerType,
    required this.registeredAddress,
    required this.stateJurisdiction,
    this.isVerified = true,
  });

  TaxInformationModel copyWith({
    String? legalBusinessName,
    String? gstin,
    String? panNumber,
    String? taxpayerType,
    String? registeredAddress,
    String? stateJurisdiction,
    bool? isVerified,
  }) {
    return TaxInformationModel(
      legalBusinessName: legalBusinessName ?? this.legalBusinessName,
      gstin: gstin ?? this.gstin,
      panNumber: panNumber ?? this.panNumber,
      taxpayerType: taxpayerType ?? this.taxpayerType,
      registeredAddress: registeredAddress ?? this.registeredAddress,
      stateJurisdiction: stateJurisdiction ?? this.stateJurisdiction,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  static const dummy = TaxInformationModel(
        legalBusinessName: 'Tandoori Tales Cloud Kitchen LLP',
        gstin: '29AAAAA0000A1Z5',
        panNumber: 'ABCDE1234F',
        taxpayerType: 'Regular Taxpayer',
        registeredAddress:
            'Plot 42, Sector 5, HSR Layout, Bangalore, Karnataka - 560102',
        stateJurisdiction: 'Karnataka (State Code 29)',
        isVerified: true,
      );
}

class ThermalPrinterDevice {
  final String name;
  final String type;
  final String address;
  final bool isConnected;

  const ThermalPrinterDevice({
    required this.name,
    required this.type,
    required this.address,
    required this.isConnected,
  });
}

class ThermalPrinterSettingsModel {
  final ThermalPrinterDevice selectedPrinter;
  final List<ThermalPrinterDevice> availablePrinters;
  final String paperSize;
  final bool autoPrintOrder;
  final bool autoPrintKot;
  final bool printCustomerDetails;

  const ThermalPrinterSettingsModel({
    required this.selectedPrinter,
    required this.availablePrinters,
    required this.paperSize,
    required this.autoPrintOrder,
    required this.autoPrintKot,
    required this.printCustomerDetails,
  });

  ThermalPrinterSettingsModel copyWith({
    ThermalPrinterDevice? selectedPrinter,
    List<ThermalPrinterDevice>? availablePrinters,
    String? paperSize,
    bool? autoPrintOrder,
    bool? autoPrintKot,
    bool? printCustomerDetails,
  }) {
    return ThermalPrinterSettingsModel(
      selectedPrinter: selectedPrinter ?? this.selectedPrinter,
      availablePrinters: availablePrinters ?? this.availablePrinters,
      paperSize: paperSize ?? this.paperSize,
      autoPrintOrder: autoPrintOrder ?? this.autoPrintOrder,
      autoPrintKot: autoPrintKot ?? this.autoPrintKot,
      printCustomerDetails:
          printCustomerDetails ?? this.printCustomerDetails,
    );
  }

  static const dummy = ThermalPrinterSettingsModel(
        selectedPrinter: ThermalPrinterDevice(
          name: 'Epson TM-T88VI',
          type: 'Bluetooth',
          address: 'BT: 00:11:22:33:44:55',
          isConnected: true,
        ),
        availablePrinters: [
          ThermalPrinterDevice(
            name: 'Epson TM-T88VI',
            type: 'Bluetooth',
            address: 'BT: 00:11:22:33:44:55',
            isConnected: true,
          ),
          ThermalPrinterDevice(
            name: 'TVS RP-3150 Star',
            type: 'WiFi / LAN',
            address: 'IP: 192.168.1.120',
            isConnected: false,
          ),
          ThermalPrinterDevice(
            name: 'Everycom EC-58 POS',
            type: 'Bluetooth',
            address: 'BT: 66:77:88:99:AA:BB',
            isConnected: false,
          ),
        ],
        paperSize: '80mm',
        autoPrintOrder: true,
        autoPrintKot: true,
        printCustomerDetails: false,
      );
}
