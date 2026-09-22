class OrderItem {
  const OrderItem({
    required this.qty,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  final String qty;
  final String title;
  final String subtitle;
  final String price;
}

class OrderDetailModel {
  const OrderDetailModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.items,
    required this.itemTotal,
    required this.gst,
    required this.packagingCharges,
    required this.deliveryFee,
    required this.grandTotal,
    this.prepTimeOptions = const [15, 25, 35, 45],
    this.defaultPrepTime = 25,
  });

  final String id;
  final String orderNumber;
  final String status;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final List<OrderItem> items;
  final String itemTotal;
  final String gst;
  final String packagingCharges;
  final String deliveryFee;
  final String grandTotal;
  final List<int> prepTimeOptions;
  final int defaultPrepTime;

  static const dummy = OrderDetailModel(
    id: '1',
    orderNumber: 'EAT1234',
    status: 'New Order',
    customerName: 'Rahul Sharma',
    customerAddress: 'Flat 402, Royal Residency, Sector 5',
    customerPhone: '+919876543210',
    items: [
      OrderItem(qty: '2x', title: 'Butter Chicken', subtitle: 'Extra spicy', price: '₹440'),
      OrderItem(qty: '1x', title: 'Naan', subtitle: 'With butter', price: '₹60'),
      OrderItem(qty: '1x', title: 'Dal Makhani', subtitle: 'No onion, no garlic', price: '₹150'),
    ],
    itemTotal: '₹650',
    gst: '₹32.50',
    packagingCharges: '₹40',
    deliveryFee: '₹27.50',
    grandTotal: '₹750',
  );
}
