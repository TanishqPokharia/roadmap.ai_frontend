// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_avatar.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateUserAvatar)
final updateUserAvatarProvider = UpdateUserAvatarProvider._();

final class UpdateUserAvatarProvider
    extends
        $FunctionalProvider<
          UpdateUserAvatar,
          UpdateUserAvatar,
          UpdateUserAvatar
        >
    with $Provider<UpdateUserAvatar> {
  UpdateUserAvatarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateUserAvatarProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateUserAvatarHash();

  @$internal
  @override
  $ProviderElement<UpdateUserAvatar> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateUserAvatar create(Ref ref) {
    return updateUserAvatar(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateUserAvatar value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateUserAvatar>(value),
    );
  }
}

String _$updateUserAvatarHash() => r'ea40d8769e2bebb0d1f95d7977ed30d0ed4dc017';
