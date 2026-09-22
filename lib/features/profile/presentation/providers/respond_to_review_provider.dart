import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/customer_reviews_model.dart';
import '../../data/models/respond_to_review_model.dart';

class RespondToReviewState {
  const RespondToReviewState({
    required this.model,
    this.replyText = '',
    this.isSubmitting = false,
  });

  final RespondToReviewModel model;
  final String replyText;
  final bool isSubmitting;

  int get characterCount => replyText.length;
  bool get canSubmit => replyText.trim().isNotEmpty && !isSubmitting;

  RespondToReviewState copyWith({
    RespondToReviewModel? model,
    String? replyText,
    bool? isSubmitting,
  }) {
    return RespondToReviewState(
      model: model ?? this.model,
      replyText: replyText ?? this.replyText,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class RespondToReviewNotifier extends Notifier<RespondToReviewState> {
  @override
  RespondToReviewState build() {
    return const RespondToReviewState(
      model: RespondToReviewModel.dummy,
    );
  }

  void initializeForReview(CustomerReviewModel review) {
    state = RespondToReviewState(
      model: RespondToReviewModel(review: review),
      replyText: '',
      isSubmitting: false,
    );
  }

  void updateReplyText(String text) {
    state = state.copyWith(replyText: text);
  }

  void applySuggestedResponse(String suggestion) {
    state = state.copyWith(replyText: suggestion);
  }

  void setSubmitting(bool submitting) {
    state = state.copyWith(isSubmitting: submitting);
  }
}

final respondToReviewProvider =
    NotifierProvider<RespondToReviewNotifier, RespondToReviewState>(
  RespondToReviewNotifier.new,
);
