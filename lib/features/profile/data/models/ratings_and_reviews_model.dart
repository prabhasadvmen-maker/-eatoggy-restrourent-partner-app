class RatingDistributionItem {
  const RatingDistributionItem({
    required this.starsLabel,
    required this.percentage,
    required this.fillRatio,
  });

  final String starsLabel;
  final int percentage;
  final double fillRatio;
}

class MonthlyPerformance {
  const MonthlyPerformance({
    required this.averageRating,
    required this.totalReviews,
    required this.responseRate,
  });

  final String averageRating;
  final int totalReviews;
  final String responseRate;
}

class CustomerReviewItem {
  const CustomerReviewItem({
    required this.id,
    required this.customerName,
    required this.rating,
    required this.timeAgo,
    required this.comment,
    required this.tag,
  });

  final String id;
  final String customerName;
  final double rating;
  final String timeAgo;
  final String comment;
  final String tag;
}

class RatingsAndReviewsModel {
  const RatingsAndReviewsModel({
    required this.partnerName,
    required this.overallRating,
    required this.verifiedReviewsCount,
    required this.distributions,
    required this.monthlyPerformance,
    required this.filterChips,
    required this.reviews,
  });

  final String partnerName;
  final String overallRating;
  final int verifiedReviewsCount;
  final List<RatingDistributionItem> distributions;
  final MonthlyPerformance monthlyPerformance;
  final List<String> filterChips;
  final List<CustomerReviewItem> reviews;

  RatingsAndReviewsModel copyWith({
    String? partnerName,
    String? overallRating,
    int? verifiedReviewsCount,
    List<RatingDistributionItem>? distributions,
    MonthlyPerformance? monthlyPerformance,
    List<String>? filterChips,
    List<CustomerReviewItem>? reviews,
  }) {
    return RatingsAndReviewsModel(
      partnerName: partnerName ?? this.partnerName,
      overallRating: overallRating ?? this.overallRating,
      verifiedReviewsCount:
          verifiedReviewsCount ?? this.verifiedReviewsCount,
      distributions: distributions ?? this.distributions,
      monthlyPerformance: monthlyPerformance ?? this.monthlyPerformance,
      filterChips: filterChips ?? this.filterChips,
      reviews: reviews ?? this.reviews,
    );
  }

  static const dummy = RatingsAndReviewsModel(
    partnerName: "Chef Giovanni's Bistro",
    overallRating: '4.3',
    verifiedReviewsCount: 234,
    distributions: [
      RatingDistributionItem(
        starsLabel: '5 Star',
        percentage: 45,
        fillRatio: 0.45,
      ),
      RatingDistributionItem(
        starsLabel: '4 Star',
        percentage: 30,
        fillRatio: 0.30,
      ),
      RatingDistributionItem(
        starsLabel: '3 Star',
        percentage: 15,
        fillRatio: 0.15,
      ),
      RatingDistributionItem(
        starsLabel: '2 Star',
        percentage: 7,
        fillRatio: 0.07,
      ),
      RatingDistributionItem(
        starsLabel: '1 Star',
        percentage: 3,
        fillRatio: 0.03,
      ),
    ],
    monthlyPerformance: MonthlyPerformance(
      averageRating: '4.5',
      totalReviews: 28,
      responseRate: '85%',
    ),
    filterChips: ['All', 'Positive', 'Negative', 'Recent'],
    reviews: [
      CustomerReviewItem(
        id: '1',
        customerName: 'Aarav Mehta',
        rating: 5.0,
        timeAgo: 'Yesterday',
        comment: 'Authentic flavors and super prompt hot packaging!',
        tag: 'Positive',
      ),
      CustomerReviewItem(
        id: '2',
        customerName: 'Priya Sharma',
        rating: 4.5,
        timeAgo: '2 days ago',
        comment: 'Great portion size and consistent taste every day.',
        tag: 'Positive',
      ),
      CustomerReviewItem(
        id: '3',
        customerName: 'Karan Patel',
        rating: 4.0,
        timeAgo: '3 days ago',
        comment: 'Fresh chapattis and nice aroma. Loved the paneer dish.',
        tag: 'Recent',
      ),
    ],
  );
}
