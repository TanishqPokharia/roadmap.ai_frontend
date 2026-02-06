// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(signUpUser)
final signUpUserProvider = SignUpUserProvider._();

final class SignUpUserProvider
    extends $FunctionalProvider<SignupUser, SignupUser, SignupUser>
    with $Provider<SignupUser> {
  SignUpUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signUpUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signUpUserHash();

  @$internal
  @override
  $ProviderElement<SignupUser> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SignupUser create(Ref ref) {
    return signUpUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignupUser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignupUser>(value),
    );
  }
}

String _$signUpUserHash() => r'0f2dec35136164aeb6aec68671f3220057310051';
