class KitchenDocumentItem {
  final String title;
  final bool isVerified;

  const KitchenDocumentItem({
    required this.title,
    this.isVerified = true,
  });
}

class KitchenProfileModel {
  final String kitchenName;
  final double rating;
  final int reviewsCount;
  final String bannerImagePath;
  final String ownerName;
  final String businessType;
  final String cuisines;
  final String address;
  final String operatingHours;
  final List<KitchenDocumentItem> documents;

  const KitchenProfileModel({
    required this.kitchenName,
    required this.rating,
    required this.reviewsCount,
    required this.bannerImagePath,
    required this.ownerName,
    required this.businessType,
    required this.cuisines,
    required this.address,
    required this.operatingHours,
    required this.documents,
  });

  KitchenProfileModel copyWith({
    String? kitchenName,
    double? rating,
    int? reviewsCount,
    String? bannerImagePath,
    String? ownerName,
    String? businessType,
    String? cuisines,
    String? address,
    String? operatingHours,
    List<KitchenDocumentItem>? documents,
  }) {
    return KitchenProfileModel(
      kitchenName: kitchenName ?? this.kitchenName,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      bannerImagePath: bannerImagePath ?? this.bannerImagePath,
      ownerName: ownerName ?? this.ownerName,
      businessType: businessType ?? this.businessType,
      cuisines: cuisines ?? this.cuisines,
      address: address ?? this.address,
      operatingHours: operatingHours ?? this.operatingHours,
      documents: documents ?? this.documents,
    );
  }

  static KitchenProfileModel get dummy => const KitchenProfileModel(
        kitchenName: 'Tandoori Tales',
        rating: 4.3,
        reviewsCount: 234,
        bannerImagePath: 'assets/images/kitchen_banner.jpg',
        ownerName: 'Harish Kumar',
        businessType: 'Cloud Kitchen',
        cuisines: 'North Indian, Chinese',
        address: 'Plot 42, Sector 5, HSR Layout, Bangalore',
        operatingHours: '10:00 AM - 10:00 PM',
        documents: [
          KitchenDocumentItem(title: 'GST Certificate', isVerified: true),
          KitchenDocumentItem(title: 'FSSAI License', isVerified: true),
          KitchenDocumentItem(title: 'Aadhaar / Identity Proof', isVerified: true),
        ],
      );
}
