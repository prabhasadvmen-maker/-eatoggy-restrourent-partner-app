class HandoverOrderModel {
  const HandoverOrderModel({
    required this.orderId,
    required this.orderNumber,
    required this.statusSteps,
    required this.currentStepIndex,
    required this.title,
    required this.description,
    required this.partnerName,
    required this.partnerVehicleNo,
    required this.partnerPhone,
  });

  final String orderId;
  final String orderNumber;
  final List<String> statusSteps;
  final int currentStepIndex;
  final String title;
  final String description;
  final String partnerName;
  final String partnerVehicleNo;
  final String partnerPhone;

  static const dummy = HandoverOrderModel(
    orderId: '1',
    orderNumber: 'EAT1234',
    statusSteps: ['Accepted', 'Preparing', 'Ready', 'Picked Up'],
    currentStepIndex: 3,
    title: 'Handed Over Successfully',
    description:
        'Order has been collected by Sumit Singh. Customer will receive it in ~30 min.',
    partnerName: 'Sumit Singh',
    partnerVehicleNo: 'DL 3S AQ 4528',
    partnerPhone: '+91 98765 43210',
  );
}
