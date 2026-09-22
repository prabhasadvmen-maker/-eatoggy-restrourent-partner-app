class OrderItemDetail {
  const OrderItemDetail({
    required this.id,
    required this.orderNumber,
    required this.timeAgo,
    required this.amount,
    required this.customerName,
    required this.itemsList,
    required this.status,
  });

  final String id;
  final String orderNumber;
  final String timeAgo;
  final String amount;
  final String customerName;
  final List<String> itemsList;
  final String status;
}

class OrdersFilterTab {
  const OrdersFilterTab({
    required this.id,
    required this.label,
    this.badgeCount = 0,
  });

  final String id;
  final String label;
  final int badgeCount;
}

class OrdersPageModel {
  const OrdersPageModel({
    required this.title,
    required this.filterTabs,
    required this.orders,
  });

  final String title;
  final List<OrdersFilterTab> filterTabs;
  final List<OrderItemDetail> orders;

  static const dummy = OrdersPageModel(
    title: 'Orders',
    filterTabs: [
      OrdersFilterTab(id: 'all', label: 'All', badgeCount: 0),
      OrdersFilterTab(id: 'new', label: 'New', badgeCount: 3),
      OrdersFilterTab(id: 'preparing', label: 'Preparing', badgeCount: 2),
      OrdersFilterTab(id: 'ready', label: 'Ready', badgeCount: 1),
      OrdersFilterTab(id: 'completed', label: 'Completed', badgeCount: 0),
    ],
    orders: [
      OrderItemDetail(
        id: '1',
        orderNumber: 'EAT1234',
        timeAgo: '5 min ago',
        amount: '₹650',
        customerName: 'Rahul Sharma',
        itemsList: ['2x Butter Chicken', '1x Naan', '1x Dal Makhani'],
        status: 'New',
      ),
      OrderItemDetail(
        id: '2',
        orderNumber: 'EAT1235',
        timeAgo: '12 min ago',
        amount: '₹380',
        customerName: 'Sneha Reddy',
        itemsList: ['1x Paneer Tikka', '2x Garlic Naan'],
        status: 'New',
      ),
      OrderItemDetail(
        id: '3',
        orderNumber: 'EAT1236',
        timeAgo: '18 min ago',
        amount: '₹520',
        customerName: 'Aman Verma',
        itemsList: ['1x Chicken Biryani', '1x Raita'],
        status: 'New',
      ),
      OrderItemDetail(
        id: '4',
        orderNumber: 'EAT1233',
        timeAgo: '25 min ago',
        amount: '₹420',
        customerName: 'Priya Patel',
        itemsList: ['2x Veg Thali', '1x Gulab Jamun'],
        status: 'Preparing',
      ),
      OrderItemDetail(
        id: '5',
        orderNumber: 'EAT1230',
        timeAgo: '32 min ago',
        amount: '₹790',
        customerName: 'Karan Mehra',
        itemsList: ['1x Mutton Curry', '3x Roti'],
        status: 'Preparing',
      ),
      OrderItemDetail(
        id: '6',
        orderNumber: 'EAT1232',
        timeAgo: '40 min ago',
        amount: '₹1,120',
        customerName: 'Amit Singh',
        itemsList: ['2x Tandoori Chicken', '4x Butter Naan'],
        status: 'Ready',
      ),
    ],
  );
}
