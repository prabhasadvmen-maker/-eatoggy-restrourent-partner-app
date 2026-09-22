class RecentOrderItem {
  const RecentOrderItem({
    required this.orderId,
    required this.customerName,
    required this.itemsCount,
    required this.amount,
    required this.timeAgo,
    required this.status,
  });

  final String orderId;
  final String customerName;
  final int itemsCount;
  final String amount;
  final String timeAgo;
  final String status;
}

class HomeModel {
  const HomeModel({
    required this.appName,
    required this.unreadNotifications,
    required this.todayOrdersCount,
    required this.todayOrdersTrend,
    required this.todayRevenue,
    required this.pendingCount,
    required this.doneCount,
    required this.newOrdersBadge,
    required this.recentOrders,
  });

  final String appName;
  final int unreadNotifications;
  final int todayOrdersCount;
  final String todayOrdersTrend;
  final String todayRevenue;
  final int pendingCount;
  final int doneCount;
  final int newOrdersBadge;
  final List<RecentOrderItem> recentOrders;

  static const dummy = HomeModel(
    appName: 'EATOGGY',
    unreadNotifications: 2,
    todayOrdersCount: 28,
    todayOrdersTrend: '+12% from yesterday',
    todayRevenue: '₹8,450',
    pendingCount: 4,
    doneCount: 24,
    newOrdersBadge: 3,
    recentOrders: [
      RecentOrderItem(
        orderId: '#ORD-9821',
        customerName: 'Rahul Verma',
        itemsCount: 3,
        amount: '₹480',
        timeAgo: '2m ago',
        status: 'New',
      ),
      RecentOrderItem(
        orderId: '#ORD-9820',
        customerName: 'Ananya Sharma',
        itemsCount: 2,
        amount: '₹320',
        timeAgo: '8m ago',
        status: 'Preparing',
      ),
      RecentOrderItem(
        orderId: '#ORD-9819',
        customerName: 'Vikram Mehta',
        itemsCount: 4,
        amount: '₹650',
        timeAgo: '15m ago',
        status: 'Ready',
      ),
    ],
  );
}
