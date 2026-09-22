import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/settings_model.dart';

class SettingsState {
  final SettingsModel model;

  const SettingsState({
    required this.model,
  });

  SettingsState copyWith({
    SettingsModel? model,
  }) {
    return SettingsState(
      model: model ?? this.model,
    );
  }
}

class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    return SettingsState(
      model: SettingsModel.dummy,
    );
  }

  void toggleOrderAlerts() {
    state = state.copyWith(
      model: state.model.copyWith(
        orderAlerts: !state.model.orderAlerts,
      ),
    );
  }

  void toggleSubscriptionReminders() {
    state = state.copyWith(
      model: state.model.copyWith(
        subscriptionReminders: !state.model.subscriptionReminders,
      ),
    );
  }

  void togglePromotionalNotifications() {
    state = state.copyWith(
      model: state.model.copyWith(
        promotionalNotifications: !state.model.promotionalNotifications,
      ),
    );
  }

  void toggleAlertSound() {
    state = state.copyWith(
      model: state.model.copyWith(
        alertSound: !state.model.alertSound,
      ),
    );
  }

  void updateLanguage(String lang) {
    state = state.copyWith(
      model: state.model.copyWith(
        language: lang,
      ),
    );
  }
}

final settingsProvider =
    NotifierProvider<SettingsNotifier, SettingsState>(
  SettingsNotifier.new,
);
