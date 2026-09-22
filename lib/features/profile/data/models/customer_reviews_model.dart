class CustomerReviewModel {
  const CustomerReviewModel({
    required this.id,
    required this.name,
    required this.timeAgo,
    required this.rating,
    required this.comment,
    this.orderedItem,
    this.isCritical = false,
    this.partnerReply,
    this.canReply = false,
  });

  final String id;
  final String name;
  final String timeAgo;
  final int rating;
  final String comment;
  final String? orderedItem;
  final bool isCritical;
  final String? partnerReply;
  final bool canReply;

  CustomerReviewModel copyWith({
    String? id,
    String? name,
    String? timeAgo,
    int? rating,
    String? comment,
    String? orderedItem,
    bool? isCritical,
    String? partnerReply,
    bool? canReply,
  }) {
    return CustomerReviewModel(
      id: id ?? this.id,
      name: name ?? this.name,
      timeAgo: timeAgo ?? this.timeAgo,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      orderedItem: orderedItem ?? this.orderedItem,
      isCritical: isCritical ?? this.isCritical,
      partnerReply: partnerReply ?? this.partnerReply,
      canReply: canReply ?? this.canReply,
    );
  }
}

class CustomerReviewsListModel {
  const CustomerReviewsListModel({
    required this.restaurantName,
    required this.reviews,
  });

  final String restaurantName;
  final List<CustomerReviewModel> reviews;

  CustomerReviewsListModel copyWith({
    String? restaurantName,
    List<CustomerReviewModel>? reviews,
  }) {
    return CustomerReviewsListModel(
      restaurantName: restaurantName ?? this.restaurantName,
      reviews: reviews ?? this.reviews,
    );
  }

  static const dummy = CustomerReviewsListModel(
    restaurantName: "Chef Giovanni's Bistro",
    reviews: [
      CustomerReviewModel(
        id: '1',
        name: 'Rahul S.',
        timeAgo: '2 days ago',
        rating: 5,
        comment:
            'Amazing butter chicken! Best in the area. Spices were spot on and tiffin packaging was very hygienic.',
        orderedItem: 'Ordered: Butter Chicken Thali',
        isCritical: false,
        canReply: false,
      ),
      CustomerReviewModel(
        id: '2',
        name: 'Anita M.',
        timeAgo: '3 days ago',
        rating: 4,
        comment:
            'Good food but delivery was slightly late. The rotis were warm and soft though. Overall good.',
        orderedItem: null,
        isCritical: false,
        canReply: false,
      ),
      CustomerReviewModel(
        id: '3',
        name: 'Vikram P.',
        timeAgo: '5 days ago',
        rating: 2,
        comment:
            'Portion size was small for the price. Quality of basmati rice was average. Expect better at this price point.',
        orderedItem: 'Ordered: Veg Deluxe Meals',
        isCritical: true,
        canReply: true,
      ),
      CustomerReviewModel(
        id: '4',
        name: 'Meera K.',
        timeAgo: '1 week ago',
        rating: 5,
        comment:
            'Love the tiffin service! Fresh and homemade taste. Has reduced my cooking worries completely. Highly recommended.',
        orderedItem: null,
        isCritical: false,
        canReply: false,
      ),
    ],
  );
}
