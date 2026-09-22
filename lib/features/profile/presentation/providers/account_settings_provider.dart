import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/account_settings_model.dart';

class AccountSettingsState {
  const AccountSettingsState({
    required this.model,
    this.isLoading = false,
  });

  final AccountSettingsModel model;
  final bool isLoading;

  AccountSettingsState copyWith({
    AccountSettingsModel? model,
    bool? isLoading,
  }) {
    return AccountSettingsState(
      model: model ?? this.model,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AccountSettingsNotifier extends Notifier<AccountSettingsState> {
  @override
  AccountSettingsState build() {
    return const AccountSettingsState(
      model: AccountSettingsModel.defaultModel,
    );
  }

  void togglePartnerStatus() {
    final currentStatus = state.model.isActive;
    state = state.copyWith(
      model: state.model.copyWith(
        isActive: !currentStatus,
        statusText: !currentStatus ? 'Active Partner' : 'Inactive Partner',
      ),
    );
  }

  void toggleNotifications() {
    final current = state.model.notificationsEnabled;
    state = state.copyWith(
      model: state.model.copyWith(
        notificationsEnabled: !current,
      ),
    );
  }

  void clearNewFeedbackBadge() {
    state = state.copyWith(
      model: state.model.copyWith(hasNewFeedback: false),
    );
  }
}

final accountSettingsProvider =
    NotifierProvider<AccountSettingsNotifier, AccountSettingsState>(
  AccountSettingsNotifier.new,
);
