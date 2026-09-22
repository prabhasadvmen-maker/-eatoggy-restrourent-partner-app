import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/assign_partner_model.dart';

class AssignPartnerState {
  const AssignPartnerState({
    required this.model,
    this.searchQuery = '',
    this.selectedPartnerId = '1',
  });

  final AssignPartnerModel model;
  final String searchQuery;
  final String selectedPartnerId;

  List<DeliveryPartnerItem> get filteredPartners {
    if (searchQuery.trim().isEmpty) {
      return model.partners;
    }
    return model.partners.where((p) {
      final query = searchQuery.toLowerCase();
      return p.name.toLowerCase().contains(query) || p.id.contains(query);
    }).toList();
  }

  AssignPartnerState copyWith({
    AssignPartnerModel? model,
    String? searchQuery,
    String? selectedPartnerId,
  }) {
    return AssignPartnerState(
      model: model ?? this.model,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedPartnerId: selectedPartnerId ?? this.selectedPartnerId,
    );
  }
}

class AssignPartnerNotifier extends Notifier<AssignPartnerState> {
  @override
  AssignPartnerState build() {
    return const AssignPartnerState(
      model: AssignPartnerModel.dummy,
      selectedPartnerId: '1',
    );
  }

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void selectPartner(String partnerId) {
    state = state.copyWith(selectedPartnerId: partnerId);
  }
}

final assignPartnerProvider =
    NotifierProvider<AssignPartnerNotifier, AssignPartnerState>(
  AssignPartnerNotifier.new,
);
