class SettingsModel {
  final String language;
  final bool orderAlerts;
  final bool subscriptionReminders;
  final bool promotionalNotifications;
  final bool alertSound;
  final String appVersion;

  const SettingsModel({
    required this.language,
    required this.orderAlerts,
    required this.subscriptionReminders,
    required this.promotionalNotifications,
    required this.alertSound,
    required this.appVersion,
  });

  SettingsModel copyWith({
    String? language,
    bool? orderAlerts,
    bool? subscriptionReminders,
    bool? promotionalNotifications,
    bool? alertSound,
    String? appVersion,
  }) {
    return SettingsModel(
      language: language ?? this.language,
      orderAlerts: orderAlerts ?? this.orderAlerts,
      subscriptionReminders:
          subscriptionReminders ?? this.subscriptionReminders,
      promotionalNotifications:
          promotionalNotifications ?? this.promotionalNotifications,
      alertSound: alertSound ?? this.alertSound,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  static SettingsModel get dummy => const SettingsModel(
        language: 'English',
        orderAlerts: true,
        subscriptionReminders: true,
        promotionalNotifications: false,
        alertSound: true,
        appVersion: 'App Version 2.1.0 Premium',
      );
}
