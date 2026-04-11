// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_with_google.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(loginUserWihGoogle)
final loginUserWihGoogleProvider = LoginUserWihGoogleProvider._();

final class LoginUserWihGoogleProvider
    extends
        $FunctionalProvider<
          LoginUserWithGoogle,
          LoginUserWithGoogle,
          LoginUserWithGoogle
        >
    with $Provider<LoginUserWithGoogle> {
  LoginUserWihGoogleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginUserWihGoogleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginUserWihGoogleHash();

  @$internal
  @override
  $ProviderElement<LoginUserWithGoogle> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LoginUserWithGoogle create(Ref ref) {
    return loginUserWihGoogle(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginUserWithGoogle value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginUserWithGoogle>(value),
    );
  }
}

String _$loginUserWihGoogleHash() =>
    r'a72782da1a0de604b8d9570bcc6bc7b493d09578';
