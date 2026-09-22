import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/edit_profile_model.dart';

class EditProfileState {
  final EditProfileModel model;
  final bool isSaving;

  const EditProfileState({
    required this.model,
    this.isSaving = false,
  });

  EditProfileState copyWith({
    EditProfileModel? model,
    bool? isSaving,
  }) {
    return EditProfileState(
      model: model ?? this.model,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class EditProfileNotifier extends Notifier<EditProfileState> {
  @override
  EditProfileState build() {
    return EditProfileState(
      model: EditProfileModel.dummy,
    );
  }

  void updateKitchenName(String name) {
    state = state.copyWith(
      model: state.model.copyWith(kitchenName: name),
    );
  }

  void updateBio(String bio) {
    state = state.copyWith(
      model: state.model.copyWith(bio: bio),
    );
  }

  void addCuisine(String cuisine) {
    if (!state.model.cuisines.contains(cuisine)) {
      final updated = List<String>.from(state.model.cuisines)..add(cuisine);
      state = state.copyWith(
        model: state.model.copyWith(cuisines: updated),
      );
    }
  }

  void removeCuisine(String cuisine) {
    final updated = List<String>.from(state.model.cuisines)..remove(cuisine);
    state = state.copyWith(
      model: state.model.copyWith(cuisines: updated),
    );
  }

  void updateOpenTime(String time) {
    state = state.copyWith(
      model: state.model.copyWith(openTime: time),
    );
  }

  void updateCloseTime(String time) {
    state = state.copyWith(
      model: state.model.copyWith(closeTime: time),
    );
  }

  void updateMinOrderValue(String value) {
    state = state.copyWith(
      model: state.model.copyWith(minOrderValue: value),
    );
  }

  void updatePrepTime(String prepTime) {
    state = state.copyWith(
      model: state.model.copyWith(prepTime: prepTime),
    );
  }

  void updateAvatarImage(String imagePath) {
    state = state.copyWith(
      model: state.model.copyWith(avatarImagePath: imagePath),
    );
  }

  Future<void> saveChanges() async {
    state = state.copyWith(isSaving: true);
    await Future.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(isSaving: false);
  }
}

final editProfileProvider =
    NotifierProvider<EditProfileNotifier, EditProfileState>(
  EditProfileNotifier.new,
);
