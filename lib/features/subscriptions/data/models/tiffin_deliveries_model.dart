class DeliveryMealItem {
  const DeliveryMealItem({
    required this.id,
    required this.customerName,
    required this.status,
    required this.itemsText,
    required this.slotText,
    required this.mealType, // 'Lunch' or 'Dinner'
  });

  final String id;
  final String customerName;
  final String status; // 'OUT FOR DELIVERY', 'PACKED', 'PREPARING'
  final String itemsText;
  final String slotText;
  final String mealType;
}

class TiffinDeliveriesModel {
  const TiffinDeliveriesModel({
    required this.title,
    required this.subtitle,
    required this.selectedDateText,
    required this.packedCount,
    required this.totalCount,
    required this.lunchCount,
    required this.dinnerCount,
    required this.deliveries,
  });

  final String title;
  final String subtitle;
  final String selectedDateText;
  final int packedCount;
  final int totalCount;
  final int lunchCount;
  final int dinnerCount;
  final List<DeliveryMealItem> deliveries;

  static const dummy = TiffinDeliveriesModel(
    title: 'Tiffin Deliveries',
    subtitle: 'Manage dispatched tiffin meals',
    selectedDateText: 'Today, 15 Aug 2026',
    packedCount: 30,
    totalCount: 45,
    lunchCount: 45,
    dinnerCount: 12,
    deliveries: [
      DeliveryMealItem(
        id: 'del_1',
        customerName: 'Rahul Sharma',
        status: 'OUT FOR DELIVERY',
        itemsText: 'Dal, Rice, 4 Roti, Sabzi',
        slotText: '12:00 PM - 1:00 PM',
        mealType: 'Lunch',
      ),
      DeliveryMealItem(
        id: 'del_2',
        customerName: 'Priya Patel',
        status: 'PACKED',
        itemsText: 'Special Khichdi, Curd, Salad',
        slotText: '12:00 PM - 1:00 PM',
        mealType: 'Lunch',
      ),
      DeliveryMealItem(
        id: 'del_3',
        customerName: 'Amit Singh',
        status: 'OUT FOR DELIVERY',
        itemsText: 'Paneer Butter Masala, 3 Paratha, Rice',
        slotText: '12:00 PM - 1:00 PM',
        mealType: 'Lunch',
      ),
      DeliveryMealItem(
        id: 'del_4',
        customerName: 'Suresh Kumar',
        status: 'PACKED',
        itemsText: 'Mix Veg, 4 Phulka, Dal Fry',
        slotText: '7:30 PM - 8:30 PM',
        mealType: 'Dinner',
      ),
      DeliveryMealItem(
        id: 'del_5',
        customerName: 'Neha Gupta',
        status: 'OUT FOR DELIVERY',
        itemsText: 'Dal Makhani, Jeera Rice, Salad',
        slotText: '7:30 PM - 8:30 PM',
        mealType: 'Dinner',
      ),
    ],
  );

  TiffinDeliveriesModel copyWith({
    String? title,
    String? subtitle,
    String? selectedDateText,
    int? packedCount,
    int? totalCount,
    int? lunchCount,
    int? dinnerCount,
    List<DeliveryMealItem>? deliveries,
  }) {
    return TiffinDeliveriesModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      selectedDateText: selectedDateText ?? this.selectedDateText,
      packedCount: packedCount ?? this.packedCount,
      totalCount: totalCount ?? this.totalCount,
      lunchCount: lunchCount ?? this.lunchCount,
      dinnerCount: dinnerCount ?? this.dinnerCount,
      deliveries: deliveries ?? this.deliveries,
    );
  }
}
