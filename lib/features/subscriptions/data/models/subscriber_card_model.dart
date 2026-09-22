class DeliveryHistoryItem {
  const DeliveryHistoryItem({
    required this.dateText,
    required this.statusText,
    required this.isDelivered, // true -> 'Delivered', false -> 'Missed / Paused'
  });

  final String dateText;
  final String statusText;
  final bool isDelivered;
}

class SubscriberCardModel {
  const SubscriberCardModel({
    required this.customerId,
    required this.customerName,
    required this.subtitle,
    required this.planTitle,
    required this.statusText,
    required this.durationText,
    required this.daysRemainingText,
    required this.deliveryAddress,
    required this.specialInstructions,
    required this.partnerPhoneNumber,
    required this.isPaused,
    required this.history,
  });

  final String customerId;
  final String customerName;
  final String subtitle;
  final String planTitle;
  final String statusText;
  final String durationText;
  final String daysRemainingText;
  final String deliveryAddress;
  final String specialInstructions;
  final String partnerPhoneNumber;
  final bool isPaused;
  final List<DeliveryHistoryItem> history;

  static const dummyPriya = SubscriberCardModel(
    customerId: 'del_2',
    customerName: 'Priya Patel',
    subtitle: 'Subscriber card information',
    planTitle: 'Monthly Tiffin Lunch',
    statusText: 'ACTIVE',
    durationText: 'Started: 1 Aug 2026 • End: 31 Aug 2026',
    daysRemainingText: '6 Days Left',
    deliveryAddress:
        '402, Shanti Sadan Heights, Vastrapur, Ahmedabad - 380015',
    specialInstructions:
        '“Please make meals without onion and keep them less spicy.”',
    partnerPhoneNumber: '+91 98765 43210',
    isPaused: false,
    history: [
      DeliveryHistoryItem(
        dateText: '14 Aug 2026',
        statusText: 'Delivered',
        isDelivered: true,
      ),
      DeliveryHistoryItem(
        dateText: '13 Aug 2026',
        statusText: 'Delivered',
        isDelivered: true,
      ),
      DeliveryHistoryItem(
        dateText: '12 Aug 2026',
        statusText: 'Missed / Paused',
        isDelivered: false,
      ),
      DeliveryHistoryItem(
        dateText: '11 Aug 2026',
        statusText: 'Delivered',
        isDelivered: true,
      ),
    ],
  );

  static const dummyRahul = SubscriberCardModel(
    customerId: 'del_1',
    customerName: 'Rahul Sharma',
    subtitle: 'Subscriber card information',
    planTitle: 'Monthly Tiffin Lunch',
    statusText: 'ACTIVE',
    durationText: 'Started: 1 Aug 2026 • End: 31 Aug 2026',
    daysRemainingText: '12 Days Left',
    deliveryAddress:
        'B-204, Royal Palms Apartment, Bodakdev, Ahmedabad - 380054',
    specialInstructions: '“Deliver at front desk security with signature.”',
    partnerPhoneNumber: '+91 98765 43210',
    isPaused: false,
    history: [
      DeliveryHistoryItem(
        dateText: '14 Aug 2026',
        statusText: 'Delivered',
        isDelivered: true,
      ),
      DeliveryHistoryItem(
        dateText: '13 Aug 2026',
        statusText: 'Delivered',
        isDelivered: true,
      ),
      DeliveryHistoryItem(
        dateText: '12 Aug 2026',
        statusText: 'Delivered',
        isDelivered: true,
      ),
      DeliveryHistoryItem(
        dateText: '11 Aug 2026',
        statusText: 'Delivered',
        isDelivered: true,
      ),
    ],
  );

  static const dummyAmit = SubscriberCardModel(
    customerId: 'del_3',
    customerName: 'Amit Singh',
    subtitle: 'Subscriber card information',
    planTitle: 'Monthly Tiffin Lunch',
    statusText: 'PAUSED',
    durationText: 'Started: 5 Aug 2026 • End: 5 Sep 2026',
    daysRemainingText: '24 Days Left',
    deliveryAddress:
        '12, Shivalik Villa, Drive In Road, Ahmedabad - 380052',
    specialInstructions: '“Please call before ringing the doorbell.”',
    partnerPhoneNumber: '+91 98765 43210',
    isPaused: true,
    history: [
      DeliveryHistoryItem(
        dateText: '14 Aug 2026',
        statusText: 'Missed / Paused',
        isDelivered: false,
      ),
      DeliveryHistoryItem(
        dateText: '13 Aug 2026',
        statusText: 'Delivered',
        isDelivered: true,
      ),
      DeliveryHistoryItem(
        dateText: '12 Aug 2026',
        statusText: 'Delivered',
        isDelivered: true,
      ),
      DeliveryHistoryItem(
        dateText: '11 Aug 2026',
        statusText: 'Delivered',
        isDelivered: true,
      ),
    ],
  );

  SubscriberCardModel copyWith({
    String? customerId,
    String? customerName,
    String? subtitle,
    String? planTitle,
    String? statusText,
    String? durationText,
    String? daysRemainingText,
    String deliveryAddress = '',
    String? specialInstructions,
    String? partnerPhoneNumber,
    bool? isPaused,
    List<DeliveryHistoryItem>? history,
  }) {
    return SubscriberCardModel(
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      subtitle: subtitle ?? this.subtitle,
      planTitle: planTitle ?? this.planTitle,
      statusText: statusText ?? this.statusText,
      durationText: durationText ?? this.durationText,
      daysRemainingText: daysRemainingText ?? this.daysRemainingText,
      deliveryAddress: deliveryAddress.isNotEmpty ? deliveryAddress : this.deliveryAddress,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      partnerPhoneNumber: partnerPhoneNumber ?? this.partnerPhoneNumber,
      isPaused: isPaused ?? this.isPaused,
      history: history ?? this.history,
    );
  }
}
