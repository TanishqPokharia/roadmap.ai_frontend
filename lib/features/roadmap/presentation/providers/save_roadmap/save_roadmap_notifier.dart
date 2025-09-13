import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/features/roadmap/domain/usecases/save_roadmap/save_roadmap.dart';
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
        .read(saveRoadmapProvider)
        .call(SaveRoadmapParams(roadmap: roadmap))
        .run();
    save.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (r) {
        state = const AsyncData(true);
      },
    );
  }
}
