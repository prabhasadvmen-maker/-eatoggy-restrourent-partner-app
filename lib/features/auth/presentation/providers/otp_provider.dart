import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/otp_model.dart';

/// State representation for OTP verification screen.
class OtpState {
  const OtpState({
    required this.data,
    this.phoneNumber = '',
    required this.digits,
    this.timerSeconds = 30,
    this.isLoading = false,
    this.errorMessage,
  });

  final OtpModel data;
  final String phoneNumber;
  final List<String> digits;
  final int timerSeconds;
  final bool isLoading;
  final String? errorMessage;

  /// Full concatenated OTP code string.
  String get otpCode => digits.join();

  /// True when all digits are filled.
  bool get isComplete =>
      digits.length == data.otpLength &&
      digits.every((digit) => digit.isNotEmpty);

  /// True when resend countdown reaches zero.
  bool get canResend => timerSeconds == 0;

  OtpState copyWith({
    OtpModel? data,
    String? phoneNumber,
    List<String>? digits,
    int? timerSeconds,
    bool? isLoading,
    String? errorMessage,
  }) {
    return OtpState(
      data: data ?? this.data,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      digits: digits ?? this.digits,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// Riverpod Notifier for managing OTP verification lifecycle, timer, and validation.
class OtpNotifier extends Notifier<OtpState> {
  Timer? _timer;

  @override
  OtpState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    const defaultModel = OtpModel.dummy;
    return OtpState(
      data: defaultModel,
      phoneNumber: '',
      digits: const ['', '', '', ''],
      timerSeconds: 30,
    );
  }

  /// Initialize OTP state with passed phone number and start resend countdown.
  void init(String phone) {
    _timer?.cancel();
    final cleanPhone = phone.trim();

    state = state.copyWith(
      phoneNumber: cleanPhone,
      digits: const ['', '', '', ''],
      timerSeconds: 30,
      isLoading: false,
      errorMessage: null,
    );

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerSeconds <= 1) {
        timer.cancel();
        state = state.copyWith(timerSeconds: 0);
      } else {
        state = state.copyWith(timerSeconds: state.timerSeconds - 1);
      }
    });
  }

  /// Updates single digit at specified index.
  void updateDigit(int index, String digit) {
    if (index < 0 || index >= state.digits.length) return;
    final newDigits = List<String>.from(state.digits);
    newDigits[index] = digit;
    state = state.copyWith(digits: newDigits, errorMessage: null);
  }

  /// Clears digit at specified index.
  void clearDigit(int index) {
    if (index < 0 || index >= state.digits.length) return;
    final newDigits = List<String>.from(state.digits);
    newDigits[index] = '';
    state = state.copyWith(digits: newDigits, errorMessage: null);
  }

  /// Resends OTP and resets timer.
  void resendOtp() {
    if (!state.canResend) return;
    state = state.copyWith(
      digits: ['', '', '', ''],
      timerSeconds: 30,
      errorMessage: null,
    );
    _startTimer();
  }

  /// Verifies entered OTP code.
  Future<bool> verifyOtp({
    required VoidCallback onSuccess,
    required ValueChanged<String> onError,
  }) async {
    if (!state.isComplete) {
      const msg = 'Please enter complete 4-digit OTP';
      state = state.copyWith(errorMessage: msg);
      onError(msg);
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate network verification delay
    await Future.delayed(const Duration(milliseconds: 700));

    state = state.copyWith(isLoading: false);
    onSuccess();
    return true;
  }
}

/// Provider for OTP Verification state management.
final otpProvider = NotifierProvider<OtpNotifier, OtpState>(
  OtpNotifier.new,
);
