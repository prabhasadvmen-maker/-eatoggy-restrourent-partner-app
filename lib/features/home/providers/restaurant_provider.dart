import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantState {
  const RestaurantState({
    required this.isOpen,
    required this.autoAcceptOrders,
    required this.soundAlerts,
    required this.restaurantName,
    required this.restaurantId,
    required this.cuisine,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.operatingHours,
  });

  final bool isOpen;
  final bool autoAcceptOrders;
  final bool soundAlerts;
  final String restaurantName;
  final String restaurantId;
  final String cuisine;
  final String address;
  final double rating;
  final int reviewCount;
  final String operatingHours;

  RestaurantState copyWith({
    bool? isOpen,
    bool? autoAcceptOrders,
    bool? soundAlerts,
    String? restaurantName,
    String? restaurantId,
    String? cuisine,
    String? address,
    double? rating,
    int? reviewCount,
    String? operatingHours,
  }) {
    return RestaurantState(
      isOpen: isOpen ?? this.isOpen,
      autoAcceptOrders: autoAcceptOrders ?? this.autoAcceptOrders,
      soundAlerts: soundAlerts ?? this.soundAlerts,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantId: restaurantId ?? this.restaurantId,
      cuisine: cuisine ?? this.cuisine,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      operatingHours: operatingHours ?? this.operatingHours,
    );
  }
}

class RestaurantNotifier extends Notifier<RestaurantState> {
  @override
  RestaurantState build() {
    return const RestaurantState(
      isOpen: true,
      autoAcceptOrders: false,
      soundAlerts: true,
      restaurantName: 'The Royal Spice Kitchen',
      restaurantId: '#EAT-84920',
      cuisine: 'North Indian & Mughlai',
      address: 'Shop 14, Sector 62, Noida, UP',
      rating: 4.8,
      reviewCount: 1240,
      operatingHours: '10:00 AM – 11:30 PM',
    );
  }

  void toggleOpenStatus(bool value) {
    state = state.copyWith(isOpen: value);
  }

  void toggleAutoAccept(bool value) {
    state = state.copyWith(autoAcceptOrders: value);
  }

  void toggleSoundAlerts(bool value) {
    state = state.copyWith(soundAlerts: value);
  }
}

final restaurantProvider =
    NotifierProvider<RestaurantNotifier, RestaurantState>(
  RestaurantNotifier.new,
);
