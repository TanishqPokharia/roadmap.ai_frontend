// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_stats_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userPostStats)
final userPostStatsProvider = UserPostStatsProvider._();

final class UserPostStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserPostStats>,
          UserPostStats,
          FutureOr<UserPostStats>
        >
    with $FutureModifier<UserPostStats>, $FutureProvider<UserPostStats> {
  UserPostStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPostStatsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPostStatsHash();

  @$internal
  @override
  $FutureProviderElement<UserPostStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserPostStats> create(Ref ref) {
    return userPostStats(ref);
  }
}

String _$userPostStatsHash() => r'deb67c0b90e802d8eec330ad0351df028b2785e8';
