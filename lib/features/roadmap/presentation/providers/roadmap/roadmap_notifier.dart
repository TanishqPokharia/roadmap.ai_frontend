import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/features/community/presentation/screens/post_page.dart';

part 'roadmap_notifier.g.dart';

@riverpod
class RoadmapNotifier extends _$RoadmapNotifier {
  @override
  FutureOr<Roadmap?> build() async {
    return null;
  }

  Future<void> getRoadmap(String prompt) async {
    state = const AsyncLoading();
    await Future.delayed(Duration(seconds: 2));
    state = AsyncData(roadmap);
  }

  Future<void> resetRoadmap() async {
    state = const AsyncData(null);
  }
}
