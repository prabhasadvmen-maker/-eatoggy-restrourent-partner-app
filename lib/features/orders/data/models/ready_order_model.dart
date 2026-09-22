class ReadyOrderModel {
  const ReadyOrderModel({
    required this.orderId,
    required this.orderNumber,
    required this.statusSteps,
    required this.currentStepIndex,
    required this.handoverTitle,
    required this.handoverSubtitle,
    required this.customerName,
    required this.itemCountText,
    required this.amount,
    required this.customerPhone,
  });

  final String orderId;
  final String orderNumber;
  final List<String> statusSteps;
  final int currentStepIndex;
  final String handoverTitle;
  final String handoverSubtitle;
  final String customerName;
  final String itemCountText;
  final String amount;
  final String customerPhone;

  static const dummy = ReadyOrderModel(
    orderId: '1',
    orderNumber: 'EAT1234',
    statusSteps: ['Accepted', 'Preparing', 'Ready', 'Picked Up'],
    currentStepIndex: 2,
    handoverTitle: 'Order Ready for Handover',
    handoverSubtitle: 'Waiting for delivery partner to arrive',
    customerName: 'Rahul Sharma',
    itemCountText: '3 items',
    amount: '₹650',
    customerPhone: '+91 98765 43210',
  );
}
