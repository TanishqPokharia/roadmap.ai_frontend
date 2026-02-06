// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_title_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostTitle)
final postTitleProvider = PostTitleProvider._();

final class PostTitleProvider extends $NotifierProvider<PostTitle, String> {
  PostTitleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postTitleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postTitleHash();

  @$internal
  @override
  PostTitle create() => PostTitle();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$postTitleHash() => r'e4a7b2f6452074c4b5b1051d93640d8729242dc0';

abstract class _$PostTitle extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
