// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_details.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getUserDetails)
final getUserDetailsProvider = GetUserDetailsProvider._();

final class GetUserDetailsProvider
    extends $FunctionalProvider<GetUserDetails, GetUserDetails, GetUserDetails>
    with $Provider<GetUserDetails> {
  GetUserDetailsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserDetailsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserDetailsHash();

  @$internal
  @override
  $ProviderElement<GetUserDetails> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetUserDetails create(Ref ref) {
    return getUserDetails(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUserDetails value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUserDetails>(value),
    );
  }
}

String _$getUserDetailsHash() => r'6ada1b41e0a373b3455de669fe7e8ce19fc0eb12';
