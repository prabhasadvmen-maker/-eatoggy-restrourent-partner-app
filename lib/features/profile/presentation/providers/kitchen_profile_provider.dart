import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/kitchen_profile_model.dart';

class KitchenProfileState {
  final KitchenProfileModel model;
  final bool isSaving;

  const KitchenProfileState({
    required this.model,
    this.isSaving = false,
  });

  KitchenProfileState copyWith({
    KitchenProfileModel? model,
    bool? isSaving,
  }) {
    return KitchenProfileState(
      model: model ?? this.model,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class KitchenProfileNotifier extends Notifier<KitchenProfileState> {
  @override
  KitchenProfileState build() {
    return KitchenProfileState(
      model: KitchenProfileModel.dummy,
    );
  }

  void updateOwnerName(String name) {
    state = state.copyWith(
      model: state.model.copyWith(ownerName: name),
    );
  }

  void updateBusinessType(String type) {
    state = state.copyWith(
      model: state.model.copyWith(businessType: type),
    );
  }

  void updateCuisines(String cuisines) {
    state = state.copyWith(
      model: state.model.copyWith(cuisines: cuisines),
    );
  }

  void updateAddress(String address) {
    state = state.copyWith(
      model: state.model.copyWith(address: address),
    );
  }

  void updateOperatingHours(String hours) {
    state = state.copyWith(
      model: state.model.copyWith(operatingHours: hours),
    );
  }

  void updateKitchenName(String name) {
    state = state.copyWith(
      model: state.model.copyWith(kitchenName: name),
    );
  }

  void updateBannerImage(String path) {
    state = state.copyWith(
      model: state.model.copyWith(bannerImagePath: path),
    );
  }

  Future<void> saveChanges() async {
    state = state.copyWith(isSaving: true);
    await Future.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(isSaving: false);
  }
}

final kitchenProfileProvider =
    NotifierProvider<KitchenProfileNotifier, KitchenProfileState>(
  KitchenProfileNotifier.new,
);
