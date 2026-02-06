// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_details.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getPostDetails)
final getPostDetailsProvider = GetPostDetailsProvider._();

final class GetPostDetailsProvider
    extends $FunctionalProvider<GetPostDetails, GetPostDetails, GetPostDetails>
    with $Provider<GetPostDetails> {
  GetPostDetailsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPostDetailsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPostDetailsHash();

  @$internal
  @override
  $ProviderElement<GetPostDetails> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetPostDetails create(Ref ref) {
    return getPostDetails(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPostDetails value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPostDetails>(value),
    );
  }
}

String _$getPostDetailsHash() => r'aa5725b8ee189bf2b7feb172e4156a8b18e0f80b';
