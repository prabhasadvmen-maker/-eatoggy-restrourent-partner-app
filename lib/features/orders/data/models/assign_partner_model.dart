class DeliveryPartnerItem {
  const DeliveryPartnerItem({
    required this.id,
    required this.name,
    required this.rating,
    required this.distance,
    required this.status,
    required this.isAvailable,
    this.isSelected = false,
  });

  final String id;
  final String name;
  final String rating;
  final String distance;
  final String status;
  final bool isAvailable;
  final bool isSelected;

  DeliveryPartnerItem copyWith({
    String? id,
    String? name,
    String? rating,
    String? distance,
    String? status,
    bool? isAvailable,
    bool? isSelected,
  }) {
    return DeliveryPartnerItem(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      distance: distance ?? this.distance,
      status: status ?? this.status,
      isAvailable: isAvailable ?? this.isAvailable,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class AssignPartnerModel {
  const AssignPartnerModel({
    required this.title,
    required this.searchHint,
    required this.sectionHeader,
    required this.partners,
  });

  final String title;
  final String searchHint;
  final String sectionHeader;
  final List<DeliveryPartnerItem> partners;

  static const dummy = AssignPartnerModel(
    title: 'Assign Partner',
    searchHint: 'Search partner name or ID...',
    sectionHeader: 'Available Partners Near You',
    partners: [
      DeliveryPartnerItem(
        id: '1',
        name: 'Sumit Singh',
        rating: '4.8',
        distance: '1.2 km away',
        status: 'Available',
        isAvailable: true,
        isSelected: true,
      ),
      DeliveryPartnerItem(
        id: '2',
        name: 'Deepak Kumar',
        rating: '4.5',
        distance: '2.4 km away',
        status: 'On Delivery',
        isAvailable: false,
        isSelected: false,
      ),
      DeliveryPartnerItem(
        id: '3',
        name: 'Rohan Das',
        rating: '4.2',
        distance: '3.1 km away',
        status: 'Available',
        isAvailable: true,
        isSelected: false,
      ),
    ],
  );
}
