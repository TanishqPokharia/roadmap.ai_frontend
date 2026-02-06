import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/features/roadmap/domain/usecases/save_roadmap/save_roadmap.dart'
    as save_roadmap_usecase;
import 'package:roadmap_ai/features/roadmap/presentation/providers/saved_roadmaps/saved_roadmaps_notifier.dart';
part 'save_roadmap_notifier.g.dart';

@riverpod
class SaveRoadmapNotifier extends _$SaveRoadmapNotifier {
  @override
  FutureOr<bool> build() {
    return false;
  }

  void saveRoadmap(Roadmap roadmap) async {
    state = AsyncLoading();
    final save = await ref
        .read(save_roadmap_usecase.saveRoadmapProvider)
        .call(save_roadmap_usecase.SaveRoadmapParams(roadmap: roadmap))
        .run();
    save.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (r) {
        ref.invalidate(savedRoadmapsProvider);
        state = const AsyncData(true);
      },
    );
  }
}
