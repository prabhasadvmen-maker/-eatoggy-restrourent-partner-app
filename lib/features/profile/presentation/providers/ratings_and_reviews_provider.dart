import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/ratings_and_reviews_model.dart';

class RatingsAndReviewsState {
  const RatingsAndReviewsState({
    required this.model,
    this.selectedFilter = 'All',
  });

  final RatingsAndReviewsModel model;
  final String selectedFilter;

  List<CustomerReviewItem> get filteredReviews {
    if (selectedFilter == 'All') return model.reviews;
    return model.reviews
        .where((r) => r.tag.toLowerCase() == selectedFilter.toLowerCase())
        .toList();
  }

  RatingsAndReviewsState copyWith({
    RatingsAndReviewsModel? model,
    String? selectedFilter,
  }) {
    return RatingsAndReviewsState(
      model: model ?? this.model,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}

class RatingsAndReviewsNotifier extends Notifier<RatingsAndReviewsState> {
  @override
  RatingsAndReviewsState build() {
    return const RatingsAndReviewsState(
      model: RatingsAndReviewsModel.dummy,
      selectedFilter: 'All',
    );
  }

  void initializeWithData(RatingsAndReviewsModel data) {
    state = state.copyWith(model: data);
  }

  void setFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
  }
}

final ratingsAndReviewsProvider =
    NotifierProvider<RatingsAndReviewsNotifier, RatingsAndReviewsState>(
  RatingsAndReviewsNotifier.new,
);
