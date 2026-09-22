import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/business_tools_model.dart';

class BankAccountState {
  final BankAccountModel model;
  final bool isSaving;

  const BankAccountState({
    required this.model,
    this.isSaving = false,
  });

  BankAccountState copyWith({
    BankAccountModel? model,
    bool? isSaving,
  }) {
    return BankAccountState(
      model: model ?? this.model,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class BankAccountNotifier extends Notifier<BankAccountState> {
  @override
  BankAccountState build() {
    return const BankAccountState(
      model: BankAccountModel.dummy,
    );
  }

  void updateDetails({
    String? bankName,
    String? accountNumber,
    String? ifscCode,
    String? beneficiaryName,
    String? accountType,
    String? branch,
  }) {
    final acc = accountNumber ?? state.model.accountNumber;
    final masked = acc.length >= 4
        ? '•••• •••• •••• ${acc.substring(acc.length - 4)}'
        : acc;

    state = state.copyWith(
      model: state.model.copyWith(
        bankName: bankName,
        accountNumber: acc,
        maskedAccountNumber: masked,
        ifscCode: ifscCode,
        beneficiaryName: beneficiaryName,
        accountType: accountType,
        branch: branch,
      ),
    );
  }

  Future<void> save() async {
    state = state.copyWith(isSaving: true);
    await Future.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(isSaving: false);
  }
}

final bankAccountProvider =
    NotifierProvider<BankAccountNotifier, BankAccountState>(
  BankAccountNotifier.new,
);

class TaxInformationState {
  final TaxInformationModel model;
  final bool isSaving;

  const TaxInformationState({
    required this.model,
    this.isSaving = false,
  });

  TaxInformationState copyWith({
    TaxInformationModel? model,
    bool? isSaving,
  }) {
    return TaxInformationState(
      model: model ?? this.model,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class TaxInformationNotifier extends Notifier<TaxInformationState> {
  @override
  TaxInformationState build() {
    return const TaxInformationState(
      model: TaxInformationModel.dummy,
    );
  }

  void updateGstin(String gstin) {
    state = state.copyWith(
      model: state.model.copyWith(gstin: gstin),
    );
  }

  void updateAddress(String address) {
    state = state.copyWith(
      model: state.model.copyWith(registeredAddress: address),
    );
  }

  Future<void> save() async {
    state = state.copyWith(isSaving: true);
    await Future.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(isSaving: false);
  }
}

final taxInformationProvider =
    NotifierProvider<TaxInformationNotifier, TaxInformationState>(
  TaxInformationNotifier.new,
);

class ThermalPrinterState {
  final ThermalPrinterSettingsModel model;
  final bool isTesting;

  const ThermalPrinterState({
    required this.model,
    this.isTesting = false,
  });

  ThermalPrinterState copyWith({
    ThermalPrinterSettingsModel? model,
    bool? isTesting,
  }) {
    return ThermalPrinterState(
      model: model ?? this.model,
      isTesting: isTesting ?? this.isTesting,
    );
  }
}

class ThermalPrinterNotifier extends Notifier<ThermalPrinterState> {
  @override
  ThermalPrinterState build() {
    return const ThermalPrinterState(
      model: ThermalPrinterSettingsModel.dummy,
    );
  }

  void selectPrinter(ThermalPrinterDevice device) {
    final updatedList = state.model.availablePrinters.map((item) {
      if (item.name == device.name) {
        return ThermalPrinterDevice(
          name: item.name,
          type: item.type,
          address: item.address,
          isConnected: true,
        );
      } else {
        return ThermalPrinterDevice(
          name: item.name,
          type: item.type,
          address: item.address,
          isConnected: false,
        );
      }
    }).toList();

    state = state.copyWith(
      model: state.model.copyWith(
        selectedPrinter: ThermalPrinterDevice(
          name: device.name,
          type: device.type,
          address: device.address,
          isConnected: true,
        ),
        availablePrinters: updatedList,
      ),
    );
  }

  void setPaperSize(String size) {
    state = state.copyWith(
      model: state.model.copyWith(paperSize: size),
    );
  }

  void toggleAutoPrintOrder() {
    state = state.copyWith(
      model: state.model.copyWith(
        autoPrintOrder: !state.model.autoPrintOrder,
      ),
    );
  }

  void toggleAutoPrintKot() {
    state = state.copyWith(
      model: state.model.copyWith(
        autoPrintKot: !state.model.autoPrintKot,
      ),
    );
  }

  void togglePrintCustomerDetails() {
    state = state.copyWith(
      model: state.model.copyWith(
        printCustomerDetails: !state.model.printCustomerDetails,
      ),
    );
  }

  Future<void> testPrint() async {
    state = state.copyWith(isTesting: true);
    await Future.delayed(const Duration(milliseconds: 700));
    state = state.copyWith(isTesting: false);
  }
}

final thermalPrinterProvider =
    NotifierProvider<ThermalPrinterNotifier, ThermalPrinterState>(
  ThermalPrinterNotifier.new,
);
