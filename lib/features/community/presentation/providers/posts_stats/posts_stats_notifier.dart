import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/no_params.dart';
import 'package:roadmap_ai/features/community/domain/entities/user_post_stats.dart';
import 'package:roadmap_ai/features/community/domain/usecases/get_user_posts_stats/get_user_posts_stats.dart';

part 'posts_stats_notifier.g.dart';

@Riverpod(keepAlive: true)
FutureOr<UserPostStats> userPostStats(Ref ref) async {
  final postsStats = await ref
      .read(getUserPostsStatsProvider)
      .call(NoParams())
      .run();
  return postsStats.fold((failure) => throw failure, (stats) => stats);
}
