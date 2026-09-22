class EditProfileModel {
  final String kitchenName;
  final String bio;
  final List<String> cuisines;
  final String openTime;
  final String closeTime;
  final String minOrderValue;
  final String prepTime;
  final String phoneNumber;
  final String? avatarImagePath;

  const EditProfileModel({
    required this.kitchenName,
    required this.bio,
    required this.cuisines,
    required this.openTime,
    required this.closeTime,
    required this.minOrderValue,
    required this.prepTime,
    required this.phoneNumber,
    this.avatarImagePath,
  });

  EditProfileModel copyWith({
    String? kitchenName,
    String? bio,
    List<String>? cuisines,
    String? openTime,
    String? closeTime,
    String? minOrderValue,
    String? prepTime,
    String? phoneNumber,
    String? avatarImagePath,
  }) {
    return EditProfileModel(
      kitchenName: kitchenName ?? this.kitchenName,
      bio: bio ?? this.bio,
      cuisines: cuisines ?? this.cuisines,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      minOrderValue: minOrderValue ?? this.minOrderValue,
      prepTime: prepTime ?? this.prepTime,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarImagePath: avatarImagePath ?? this.avatarImagePath,
    );
  }

  static EditProfileModel get dummy => const EditProfileModel(
        kitchenName: 'Tandoori Tales',
        bio:
            'Traditional North Indian meals and custom daily tiffin service made with fresh ingredients.',
        cuisines: ['North Indian', 'Chinese', 'Beverages'],
        openTime: '10:00 AM',
        closeTime: '10:00 PM',
        minOrderValue: '₹150',
        prepTime: '25 mins',
        phoneNumber: '+91 98765 43210',
        avatarImagePath: null,
      );
}
