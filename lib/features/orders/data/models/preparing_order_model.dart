class PreparationCheckItem {
  const PreparationCheckItem({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  final String id;
  final String title;
  final bool isDone;

  PreparationCheckItem copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return PreparationCheckItem(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}

class PreparingOrderModel {
  const PreparingOrderModel({
    required this.orderId,
    required this.orderNumber,
    required this.statusSteps,
    required this.currentStepIndex,
    required this.remainingTime,
    required this.acceptingMoreOrdersText,
    required this.checklist,
    required this.customerPhone,
    required this.deliveryPartnerPhone,
  });

  final String orderId;
  final String orderNumber;
  final List<String> statusSteps;
  final int currentStepIndex;
  final String remainingTime;
  final String acceptingMoreOrdersText;
  final List<PreparationCheckItem> checklist;
  final String customerPhone;
  final String deliveryPartnerPhone;

  static const dummy = PreparingOrderModel(
    orderId: '1',
    orderNumber: 'EAT1234',
    statusSteps: ['Accepted', 'Preparing', 'Ready', 'Picked Up'],
    currentStepIndex: 1,
    remainingTime: '25:00',
    acceptingMoreOrdersText: 'Accepting more order requests',
    checklist: [
      PreparationCheckItem(id: '1', title: '2x Butter Chicken', isDone: true),
      PreparationCheckItem(id: '2', title: '1x Naan', isDone: true),
      PreparationCheckItem(id: '3', title: '1x Dal Makhani', isDone: false),
    ],
    customerPhone: '+91 98765 43210',
    deliveryPartnerPhone: '+91 91234 56789',
  );
}
