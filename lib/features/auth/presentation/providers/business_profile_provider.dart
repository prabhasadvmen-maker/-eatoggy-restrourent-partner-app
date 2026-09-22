import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/business_profile_model.dart';

/// State representation for Business Profile onboarding.
class BusinessProfileState {
  const BusinessProfileState({
    required this.data,
    this.restaurantName = '',
    this.ownerName = '',
    this.businessType = 'Cloud Kitchen',
    this.phone = '',
    this.email = '',
    this.address = '',
    this.isLoading = false,
    this.errorMessage,
  });

  final BusinessProfileModel data;
  final String restaurantName;
  final String ownerName;
  final String businessType;
  final String phone;
  final String email;
  final String address;
  final bool isLoading;
  final String? errorMessage;

  BusinessProfileState copyWith({
    BusinessProfileModel? data,
    String? restaurantName,
    String? ownerName,
    String? businessType,
    String? phone,
    String? email,
    String? address,
    bool? isLoading,
    String? errorMessage,
  }) {
    return BusinessProfileState(
      data: data ?? this.data,
      restaurantName: restaurantName ?? this.restaurantName,
      ownerName: ownerName ?? this.ownerName,
      businessType: businessType ?? this.businessType,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// Riverpod Notifier for managing Business Profile onboarding form & state.
class BusinessProfileNotifier extends Notifier<BusinessProfileState> {
  @override
  BusinessProfileState build() {
    const dummyData = BusinessProfileModel.dummy;
    return const BusinessProfileState(
      data: dummyData,
      restaurantName: '',
      ownerName: '',
      businessType: 'Cloud Kitchen',
      phone: '',
      email: '',
      address: '',
    );
  }

  void updateRestaurantName(String value) {
    state = state.copyWith(restaurantName: value, errorMessage: null);
  }

  void updateOwnerName(String value) {
    state = state.copyWith(ownerName: value, errorMessage: null);
  }

  void updateBusinessType(String value) {
    state = state.copyWith(businessType: value, errorMessage: null);
  }

  void updatePhone(String value) {
    state = state.copyWith(phone: value, errorMessage: null);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value, errorMessage: null);
  }

  void updateAddress(String value) {
    state = state.copyWith(address: value, errorMessage: null);
  }

  Future<bool> submitProfile({
    required VoidCallback onSuccess,
    required ValueChanged<String> onError,
  }) async {
    final cleanPhone = state.phone.replaceAll(RegExp(r'\D'), '');
    if (cleanPhone.isNotEmpty && cleanPhone.length != 10) {
      const msg = 'Please enter a valid 10-digit phone number';
      state = state.copyWith(errorMessage: msg);
      onError(msg);
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate API submission delay
    await Future.delayed(const Duration(milliseconds: 600));

    state = state.copyWith(isLoading: false);
    onSuccess();
    return true;
  }
}

/// Provider for Business Profile state management.
final businessProfileProvider =
    NotifierProvider<BusinessProfileNotifier, BusinessProfileState>(
  BusinessProfileNotifier.new,
);
