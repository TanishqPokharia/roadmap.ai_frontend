// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_posts_by_author.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getPostsByAuthor)
final getPostsByAuthorProvider = GetPostsByAuthorProvider._();

final class GetPostsByAuthorProvider
    extends
        $FunctionalProvider<
          GetPostsByAuthor,
          GetPostsByAuthor,
          GetPostsByAuthor
        >
    with $Provider<GetPostsByAuthor> {
  GetPostsByAuthorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPostsByAuthorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPostsByAuthorHash();

  @$internal
  @override
  $ProviderElement<GetPostsByAuthor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetPostsByAuthor create(Ref ref) {
    return getPostsByAuthor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPostsByAuthor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPostsByAuthor>(value),
    );
  }
}

String _$getPostsByAuthorHash() => r'caf264bfcfc25c9f176d591f63999d08b537e458';
