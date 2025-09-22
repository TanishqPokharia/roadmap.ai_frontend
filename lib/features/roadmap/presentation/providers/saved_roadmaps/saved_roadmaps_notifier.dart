import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap_metadata.dart';
import 'package:roadmap_ai/features/roadmap/domain/usecases/get_saved_roadmaps_metadata/get_saved_roadmaps_metadata.dart';

part 'saved_roadmaps_notifier.g.dart';

class SavedRoadmapsState {
  final List<RoadmapMetadata> roadmaps;
  final bool canGetMore;
  final String? error;

  SavedRoadmapsState({
    required this.roadmaps,
    required this.canGetMore,
    this.error,
  });
}

@Riverpod(keepAlive: true)
class SavedRoadmapsNotifier extends _$SavedRoadmapsNotifier {
  final int _limit = 10;
  int _skip = 0;
  final List<RoadmapMetadata> _roadmaps = [];
  bool _canGetMore = true;

  @override
  FutureOr<SavedRoadmapsState> build() async {
    final roadmapsMetaData = await ref
        .read(getSavedRoadmapsMetadataProvider)
        .call(GetSavedRoadmapsMetadataParams(limit: _limit, skip: _skip))
        .run();
    return roadmapsMetaData.fold((failure) => throw failure, (data) {
      _roadmaps.addAll(data);
      if (data.length < _limit) {
        _canGetMore = false;
      }
      return SavedRoadmapsState(roadmaps: _roadmaps, canGetMore: _canGetMore);
    });
  }

  void refresh() async {
    _skip = 0;
    _roadmaps.clear();
    _canGetMore = true;
    state = const AsyncLoading();
    final roadmapsMetaData = await ref
        .read(getSavedRoadmapsMetadataProvider)
        .call(GetSavedRoadmapsMetadataParams(limit: _limit, skip: _skip))
        .run();
    roadmapsMetaData.fold(
      (failure) {
        state = AsyncData(
          SavedRoadmapsState(
            roadmaps: _roadmaps,
            canGetMore: _canGetMore,
            error: failure.message,
          ),
        );
      },
      (data) {
        _roadmaps.addAll(data);
        if (data.length < _limit) {
          _canGetMore = false;
        }
        state = AsyncData(
          SavedRoadmapsState(roadmaps: _roadmaps, canGetMore: _canGetMore),
        );
      },
    );
  }

  void getNextPage() async {
    if (!_canGetMore) return;
    _skip += _limit;
    final roadmapsMetaData = await ref
        .read(getSavedRoadmapsMetadataProvider)
        .call(GetSavedRoadmapsMetadataParams(limit: _limit, skip: _skip))
        .run();

    roadmapsMetaData.fold(
      (failure) {
        _canGetMore = false;
        state = AsyncData(
          SavedRoadmapsState(
            roadmaps: _roadmaps,
            canGetMore: _canGetMore,
            error: failure.message,
          ),
        );
      },
      (data) {
        _roadmaps.addAll(data);
        if (data.length < _limit) {
          _canGetMore = false;
        }
        state = AsyncData(
          SavedRoadmapsState(roadmaps: _roadmaps, canGetMore: _canGetMore),
        );
      },
    );
  }

  void updateRoadmapProgress(
    String roadmapId,
    int completedSubgoals,
    int totalSubgoals,
  ) {
    final index = _roadmaps.indexWhere((roadmap) => roadmap.id == roadmapId);
    if (index == -1) return;

    final updatedRoadmapMetaData = _roadmaps[index].copyWith(
      completedSubgoals: completedSubgoals,
    );
    _roadmaps[index] = updatedRoadmapMetaData;

    state = AsyncData(
      SavedRoadmapsState(roadmaps: _roadmaps, canGetMore: _canGetMore),
    );
  }
}
