// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(createPost)
final createPostProvider = CreatePostProvider._();

final class CreatePostProvider
    extends $FunctionalProvider<CreatePost, CreatePost, CreatePost>
    with $Provider<CreatePost> {
  CreatePostProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createPostProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createPostHash();

  @$internal
  @override
  $ProviderElement<CreatePost> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CreatePost create(Ref ref) {
    return createPost(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreatePost value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreatePost>(value),
    );
  }
}

String _$createPostHash() => r'37cc9aa3867cd050a8803d2190801000f1033cba';
