import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/customer_reviews_model.dart';

class CustomerReviewsState {
  const CustomerReviewsState({
    required this.model,
  });

  final CustomerReviewsListModel model;

  CustomerReviewsState copyWith({
    CustomerReviewsListModel? model,
  }) {
    return CustomerReviewsState(
      model: model ?? this.model,
    );
  }
}

class CustomerReviewsNotifier extends Notifier<CustomerReviewsState> {
  @override
  CustomerReviewsState build() {
    return const CustomerReviewsState(
      model: CustomerReviewsListModel.dummy,
    );
  }

  void initializeWithModel(CustomerReviewsListModel model) {
    state = state.copyWith(model: model);
  }

  void addPartnerReply(String reviewId, String replyText) {
    final updatedList = state.model.reviews.map((item) {
      if (item.id == reviewId) {
        return item.copyWith(
          partnerReply: replyText,
          canReply: false,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(
      model: state.model.copyWith(reviews: updatedList),
    );
  }
}

final customerReviewsProvider =
    NotifierProvider<CustomerReviewsNotifier, CustomerReviewsState>(
  CustomerReviewsNotifier.new,
);
