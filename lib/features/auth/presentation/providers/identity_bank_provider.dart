import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/identity_bank_model.dart';

class IdentityBankState {
  const IdentityBankState({
    required this.data,
    this.aadhaarPath,
    this.isAadhaarUploaded = false,
    this.accountHolderName = '',
    this.accountNumber = '',
    this.ifscCode = '',
    this.bankName = '',
    this.isLoading = false,
    this.errorMessage,
  });

  final IdentityBankModel data;
  final String? aadhaarPath;
  final bool isAadhaarUploaded;
  final String accountHolderName;
  final String accountNumber;
  final String ifscCode;
  final String bankName;
  final bool isLoading;
  final String? errorMessage;

  IdentityBankState copyWith({
    IdentityBankModel? data,
    String? aadhaarPath,
    bool? isAadhaarUploaded,
    String? accountHolderName,
    String? accountNumber,
    String? ifscCode,
    String? bankName,
    bool? isLoading,
    String? errorMessage,
  }) {
    return IdentityBankState(
      data: data ?? this.data,
      aadhaarPath: aadhaarPath ?? this.aadhaarPath,
      isAadhaarUploaded: isAadhaarUploaded ?? this.isAadhaarUploaded,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      accountNumber: accountNumber ?? this.accountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      bankName: bankName ?? this.bankName,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class IdentityBankNotifier extends Notifier<IdentityBankState> {
  final ImagePicker _picker = ImagePicker();

  @override
  IdentityBankState build() {
    return const IdentityBankState(
      data: IdentityBankModel.dummy,
      accountHolderName: '',
      accountNumber: '',
      ifscCode: '',
      bankName: '',
    );
  }

  Future<void> pickAadhaar(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (image != null) {
        state = state.copyWith(
          aadhaarPath: image.path,
          isAadhaarUploaded: true,
          errorMessage: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Failed to pick image: ${e.toString()}',
      );
    }
  }

  void updateAccountHolderName(String value) {
    state = state.copyWith(accountHolderName: value, errorMessage: null);
  }

  void updateAccountNumber(String value) {
    state = state.copyWith(accountNumber: value, errorMessage: null);
  }

  void updateIfscCode(String value) {
    state = state.copyWith(ifscCode: value, errorMessage: null);
  }

  void updateBankName(String value) {
    state = state.copyWith(bankName: value, errorMessage: null);
  }

  Future<bool> submitIdentityBank({
    required VoidCallback onSuccess,
    required ValueChanged<String> onError,
  }) async {
    if (!state.isAadhaarUploaded) {
      const msg = 'Please upload Aadhaar Card (Front & Back)';
      state = state.copyWith(errorMessage: msg);
      onError(msg);
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    await Future.delayed(const Duration(milliseconds: 700));

    state = state.copyWith(isLoading: false);
    onSuccess();
    return true;
  }
}

final identityBankProvider =
    NotifierProvider<IdentityBankNotifier, IdentityBankState>(
  IdentityBankNotifier.new,
);
