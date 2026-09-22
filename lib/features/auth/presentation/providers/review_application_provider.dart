import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/review_application_model.dart';

class ReviewApplicationState {
  const ReviewApplicationState({
    required this.data,
    this.isLoading = false,
    this.errorMessage,
  });

  final ReviewApplicationModel data;
  final bool isLoading;
  final String? errorMessage;

  ReviewApplicationState copyWith({
    ReviewApplicationModel? data,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ReviewApplicationState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class ReviewApplicationNotifier
    extends Notifier<ReviewApplicationState> {
  @override
  ReviewApplicationState build() {
    return const ReviewApplicationState(
      data: ReviewApplicationModel.dummy,
    );
  }

  Future<bool> submitApplication({
    required VoidCallback onSuccess,
    required ValueChanged<String> onError,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    await Future.delayed(const Duration(milliseconds: 1000));

    state = state.copyWith(isLoading: false);
    onSuccess();
    return true;
  }
}

final reviewApplicationProvider = NotifierProvider<
    ReviewApplicationNotifier, ReviewApplicationState>(
  ReviewApplicationNotifier.new,
);
