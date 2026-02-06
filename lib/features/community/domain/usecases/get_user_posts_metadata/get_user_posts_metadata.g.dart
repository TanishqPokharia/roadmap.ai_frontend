// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_posts_metadata.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getUserPostsMetaData)
final getUserPostsMetaDataProvider = GetUserPostsMetaDataProvider._();

final class GetUserPostsMetaDataProvider
    extends
        $FunctionalProvider<
          GetUserPostsMetadata,
          GetUserPostsMetadata,
          GetUserPostsMetadata
        >
    with $Provider<GetUserPostsMetadata> {
  GetUserPostsMetaDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserPostsMetaDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserPostsMetaDataHash();

  @$internal
  @override
  $ProviderElement<GetUserPostsMetadata> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetUserPostsMetadata create(Ref ref) {
    return getUserPostsMetaData(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUserPostsMetadata value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUserPostsMetadata>(value),
    );
  }
}

String _$getUserPostsMetaDataHash() =>
    r'8ddca3ce2b2ca185724a7fc376302ebc66cdb031';
