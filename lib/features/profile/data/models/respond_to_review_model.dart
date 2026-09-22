import 'customer_reviews_model.dart';

class RespondToReviewModel {
  const RespondToReviewModel({
    required this.review,
    this.suggestedResponses = const [
      'We apologize for the inconvenience and will improve...',
      'Thank you for your feedback. We are adjusting portions...',
      'We have noted your concern and passed it to the head chef...',
    ],
    this.maxCharacters = 500,
  });

  final CustomerReviewModel review;
  final List<String> suggestedResponses;
  final int maxCharacters;

  static const dummy = RespondToReviewModel(
    review: CustomerReviewModel(
      id: '3',
      name: 'Vikram P.',
      timeAgo: '5 days ago',
      rating: 2,
      comment: 'Portion size was small for the price.',
      isCritical: true,
      canReply: true,
    ),
  );
}
