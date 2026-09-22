import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/login_model.dart';

/// State object for Partner Login screen state management.
class LoginState {
  const LoginState({
    required this.data,
    this.phoneNumber = '',
    this.isLoading = false,
    this.errorMessage,
  });

  final LoginModel data;
  final String phoneNumber;
  final bool isLoading;
  final String? errorMessage;

  /// Sanitized digits-only phone number.
  String get sanitizedPhoneNumber =>
      phoneNumber.replaceAll(RegExp(r'\D'), '');

  /// Checks if current entered phone number is a valid 10-digit mobile number.
  bool get isValid => sanitizedPhoneNumber.length == 10;

  LoginState copyWith({
    LoginModel? data,
    String? phoneNumber,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      data: data ?? this.data,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// Riverpod Notifier for handling Login state, input validation, and submission logic.
class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    return const LoginState(data: LoginModel.dummy);
  }

  /// Update mobile number in state with validation check.
  void updatePhoneNumber(String value) {
    state = state.copyWith(
      phoneNumber: value,
      errorMessage: null,
    );
  }

  /// Sets dummy phone number into state.
  void setDummyPhoneNumber() {
    final dummyClean = state.data.dummyPhoneNumber.replaceAll(' ', '');
    state = state.copyWith(
      phoneNumber: dummyClean,
      errorMessage: null,
    );
  }

  /// Handles OTP login submission.
  Future<bool> loginWithOtp({
    required VoidCallback onSuccess,
    required ValueChanged<String> onError,
  }) async {
    final cleanPhone = state.sanitizedPhoneNumber;
    if (cleanPhone.isEmpty) {
      const msg = 'Please enter your registered mobile number';
      state = state.copyWith(errorMessage: msg);
      onError(msg);
      return false;
    }

    if (cleanPhone.length < 10) {
      const msg = 'Please enter a valid 10-digit mobile number';
      state = state.copyWith(errorMessage: msg);
      onError(msg);
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate API request delay
    await Future.delayed(const Duration(milliseconds: 600));

    state = state.copyWith(isLoading: false);
    onSuccess();
    return true;
  }
}

/// Provider for Partner Login state management.
final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);
