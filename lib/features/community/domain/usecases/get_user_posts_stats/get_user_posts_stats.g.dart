// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_posts_stats.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getUserPostsStats)
final getUserPostsStatsProvider = GetUserPostsStatsProvider._();

final class GetUserPostsStatsProvider
    extends
        $FunctionalProvider<
          GetUserPostsStats,
          GetUserPostsStats,
          GetUserPostsStats
        >
    with $Provider<GetUserPostsStats> {
  GetUserPostsStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserPostsStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserPostsStatsHash();

  @$internal
  @override
  $ProviderElement<GetUserPostsStats> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetUserPostsStats create(Ref ref) {
    return getUserPostsStats(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUserPostsStats value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUserPostsStats>(value),
    );
  }
}

String _$getUserPostsStatsHash() => r'b3d07170c1775c0b4b6fe17d463397f5e00c3744';
