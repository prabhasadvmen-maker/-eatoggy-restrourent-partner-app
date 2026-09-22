class KitchenScreenModel {
  const KitchenScreenModel({
    required this.appName,
    required this.isOnline,
    required this.onlineStatusTitle,
    required this.onlineStatusSubtitle,
    required this.totalHours,
    required this.activeQueue,
    required this.autoAcceptSubscription,
    required this.dailyClosingTime,
    required this.afternoonBreakSlot,
  });

  final String appName;
  final bool isOnline;
  final String onlineStatusTitle;
  final String onlineStatusSubtitle;
  final String totalHours;
  final String activeQueue;
  final bool autoAcceptSubscription;
  final String dailyClosingTime;
  final String afternoonBreakSlot;

  static const dummy = KitchenScreenModel(
    appName: 'EATOGGY',
    isOnline: true,
    onlineStatusTitle: 'Kitchen is Currently Online',
    onlineStatusSubtitle: 'Online since 9:00 AM today',
    totalHours: '6h 30m',
    activeQueue: '3 Orders',
    autoAcceptSubscription: true,
    dailyClosingTime: '11:00 PM',
    afternoonBreakSlot: '4:00 - 6:00 PM',
  );
}
