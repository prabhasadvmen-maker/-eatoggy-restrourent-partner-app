import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/help_support_model.dart';

class HelpSupportState {
  final HelpSupportModel model;
  final String? expandedFaqId;
  final String searchQuery;
  final String selectedCategory;
  final String issueDescription;
  final bool isSubmitting;

  const HelpSupportState({
    required this.model,
    this.expandedFaqId = 'faq_1',
    this.searchQuery = '',
    this.selectedCategory = 'Payout Issue',
    this.issueDescription = '',
    this.isSubmitting = false,
  });

  List<FaqItemModel> get filteredFaqs {
    if (searchQuery.trim().isEmpty) {
      return model.faqs;
    }
    final q = searchQuery.toLowerCase().trim();
    return model.faqs.where((faq) {
      return faq.question.toLowerCase().contains(q) ||
          faq.answer.toLowerCase().contains(q);
    }).toList();
  }

  HelpSupportState copyWith({
    HelpSupportModel? model,
    String? expandedFaqId,
    bool clearExpanded = false,
    String? searchQuery,
    String? selectedCategory,
    String? issueDescription,
    bool? isSubmitting,
  }) {
    return HelpSupportState(
      model: model ?? this.model,
      expandedFaqId:
          clearExpanded ? null : (expandedFaqId ?? this.expandedFaqId),
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      issueDescription: issueDescription ?? this.issueDescription,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class HelpSupportNotifier extends Notifier<HelpSupportState> {
  @override
  HelpSupportState build() {
    return HelpSupportState(
      model: HelpSupportModel.dummy,
    );
  }

  void toggleFaq(String faqId) {
    if (state.expandedFaqId == faqId) {
      state = state.copyWith(clearExpanded: true);
    } else {
      state = state.copyWith(expandedFaqId: faqId);
    }
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void updateIssueDescription(String text) {
    state = state.copyWith(issueDescription: text);
  }

  Future<bool> submitTicket() async {
    if (state.issueDescription.trim().isEmpty) {
      return false;
    }
    state = state.copyWith(isSubmitting: true);
    await Future.delayed(const Duration(milliseconds: 600));
    state = state.copyWith(
      isSubmitting: false,
      issueDescription: '',
    );
    return true;
  }
}

final helpSupportProvider =
    NotifierProvider<HelpSupportNotifier, HelpSupportState>(
  HelpSupportNotifier.new,
);
