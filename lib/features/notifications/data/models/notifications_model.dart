class NotificationItem {
  const NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.timeAgo,
    this.isUnread = false,
  });

  final String id;
  final String title;
  final String description;
  final String timeAgo;
  final bool isUnread;

  NotificationItem copyWith({
    String? id,
    String? title,
    String? description,
    String? timeAgo,
    bool? isUnread,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timeAgo: timeAgo ?? this.timeAgo,
      isUnread: isUnread ?? this.isUnread,
    );
  }
}

class NotificationsSection {
  const NotificationsSection({
    required this.sectionTitle,
    required this.items,
  });

  final String sectionTitle;
  final List<NotificationItem> items;
}

class NotificationsPageModel {
  const NotificationsPageModel({
    required this.title,
    required this.actionText,
    required this.sections,
  });

  final String title;
  final String actionText;
  final List<NotificationsSection> sections;

  static const dummy = NotificationsPageModel(
    title: 'Notifications',
    actionText: 'Mark all read',
    sections: [
      NotificationsSection(
        sectionTitle: 'TODAY',
        items: [
          NotificationItem(
            id: '1',
            title: 'New order received #EAT1240',
            description: 'Customer Rahul has ordered 3 items.',
            timeAgo: '2 min ago',
            isUnread: true,
          ),
          NotificationItem(
            id: '2',
            title: 'Order #EAT1235 picked up',
            description: 'Delivery partner Sumit has collected the order.',
            timeAgo: '15 min ago',
            isUnread: false,
          ),
          NotificationItem(
            id: '3',
            title: 'Payout credited',
            description: 'Amount of ₹1,200 has been processed to your bank.',
            timeAgo: '1 hr ago',
            isUnread: false,
          ),
        ],
      ),
      NotificationsSection(
        sectionTitle: 'YESTERDAY',
        items: [
          NotificationItem(
            id: '4',
            title: 'New 4-star review received',
            description: "Customer Amit said: 'Amazing packing and hot food.'",
            timeAgo: '1 day ago',
            isUnread: false,
          ),
          NotificationItem(
            id: '5',
            title: 'Subscription reminder',
            description:
                'You have 4 subscription order deliveries scheduled for tomorrow.',
            timeAgo: '1 day ago',
            isUnread: false,
          ),
          NotificationItem(
            id: '6',
            title: 'Documents verified successfully',
            description: 'FSSAI registration documents approved.',
            timeAgo: '2 days ago',
            isUnread: false,
          ),
        ],
      ),
    ],
  );
}
