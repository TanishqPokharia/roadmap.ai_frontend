import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/no_params.dart';
import 'package:roadmap_ai/features/auth/domain/entities/user_details.dart';
import 'package:roadmap_ai/features/auth/domain/usecases/get_user_details/get_user_details.dart';
import 'package:roadmap_ai/features/auth/domain/usecases/update_user_avatar/update_user_avatar.dart';

part 'profile_notifier.g.dart';

class ProfileState {
  final UserDetails userDetails;
  final String? error;

  ProfileState({required this.userDetails, this.error});
}

@Riverpod(keepAlive: true)
class ProfileNotifier extends _$ProfileNotifier {
  @override
  FutureOr<ProfileState> build() async {
    final userDetails = await ref
        .read(getUserDetailsProvider)
        .call(NoParams())
        .run();
    return userDetails.fold(
      (failure) => throw failure,
      (userDetails) => ProfileState(userDetails: userDetails),
    );
  }

  void refresh() async {
    state = const AsyncLoading();
    final userDetails = await ref
        .read(getUserDetailsProvider)
        .call(NoParams())
        .run();
    userDetails.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (userDetails) =>
          state = AsyncData(ProfileState(userDetails: userDetails)),
    );
  }

  void changeAvatar(FilePickerResult file) async {
    final currentState = state as AsyncData<ProfileState>;
    state = const AsyncLoading();
    final changedAvatar = await ref
        .read(updateUserAvatarProvider)
        .call(UpdateUserAvatarParams(image: file))
        .run();

    changedAvatar.fold(
      (failure) => state = AsyncData(
        ProfileState(
          userDetails: currentState.value.userDetails,
          error: failure.message,
        ),
      ),
      (newAvatarUrl) {
        final updatedUserDetails = UserDetails(
          username: currentState.value.userDetails.username,
          email: currentState.value.userDetails.email,
          avatarUrl: newAvatarUrl,
        );
        state = AsyncData(ProfileState(userDetails: updatedUserDetails));
      },
    );
  }
}
