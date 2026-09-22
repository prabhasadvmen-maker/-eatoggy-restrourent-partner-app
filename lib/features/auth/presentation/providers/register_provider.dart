import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/register_model.dart';

/// State object for Partner Registration screen.
class RegisterState {
  const RegisterState({
    required this.data,
    this.isLoading = false,
    this.errorMessage,
  });

  final RegisterModel data;
  final bool isLoading;
  final String? errorMessage;

  RegisterState copyWith({
    RegisterModel? data,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RegisterState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// Riverpod Notifier for managing Partner Registration state and initiation logic.
class RegisterNotifier extends Notifier<RegisterState> {
  @override
  RegisterState build() {
    return const RegisterState(data: RegisterModel.dummy);
  }

  /// Start registration process.
  Future<void> startRegistration({
    required VoidCallback onSuccess,
    required ValueChanged<String> onError,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate registration setup delay
    await Future.delayed(const Duration(milliseconds: 600));

    state = state.copyWith(isLoading: false);
    onSuccess();
  }
}

/// Provider for Partner Registration state management.
final registerProvider = NotifierProvider<RegisterNotifier, RegisterState>(
  RegisterNotifier.new,
);
