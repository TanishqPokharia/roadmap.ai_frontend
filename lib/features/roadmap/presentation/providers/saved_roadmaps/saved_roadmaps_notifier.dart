import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap_metadata.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/login/login_notifier.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/signup/signup_notifier.dart';
import 'package:roadmap_ai/features/roadmap/domain/usecases/get_saved_roadmaps_metadata/get_saved_roadmaps_metadata.dart';

part 'saved_roadmaps_notifier.g.dart';
part 'saved_roadmaps_notifier.freezed.dart';

@freezed
abstract class SavedRoadmapsState with _$SavedRoadmapsState {
  const factory SavedRoadmapsState({
    required List<RoadmapMetadata> roadmaps,
    @Default(true) bool canGetMore,
    String? error,
    @Default(false) bool isFetching,
  }) = _SavedRoadmapsState;
}

@Riverpod(keepAlive: true)
class SavedRoadmapsNotifier extends _$SavedRoadmapsNotifier {
  final int _limit = 4;
  int _skip = 0;
  final List<RoadmapMetadata> _roadmaps = [];
  bool _canGetMore = true;
  bool _isFetching = false;
  @override
  FutureOr<SavedRoadmapsState> build() async {
    ref.watch(loginProvider);
    ref.watch(signupProvider);
    _skip = 0;
    _roadmaps.clear();
    _canGetMore = true;
    _isFetching = true;

    final roadmapsMetaData = await ref
        .read(getSavedRoadmapsMetadataProvider)
        .call(GetSavedRoadmapsMetadataParams(limit: _limit, skip: _skip))
        .run();
    return roadmapsMetaData.fold(
      (failure) {
        _isFetching = false;
        _canGetMore = false;
        throw failure;
      },
      (data) {
        _roadmaps.addAll(data);

        if (data.length < _limit) {
          _canGetMore = false;
        }

        _isFetching = false;

        final result = SavedRoadmapsState(
          roadmaps: _roadmaps,
          canGetMore: _canGetMore,
          isFetching: _isFetching,
        );

        return result;
      },
    );
  }

  void reset() => ref.invalidateSelf();

  void getNextPage() async {
    // exit if cannot get more
    if (!_canGetMore) return;

    // return if already fetching next page
    if (_isFetching) return;

    // set is fetching to true
    _isFetching = true;
    state = AsyncData(state.value!.copyWith(isFetching: _isFetching));

    _skip += _limit;
    final roadmapsMetaData = await ref
        .read(getSavedRoadmapsMetadataProvider)
        .call(GetSavedRoadmapsMetadataParams(limit: _limit, skip: _skip))
        .run();

    roadmapsMetaData.fold(
      (failure) {
        _canGetMore = false;
        _isFetching = false;
        state = AsyncData(
          SavedRoadmapsState(
            roadmaps: _roadmaps,
            canGetMore: _canGetMore,
            error: failure.message,
            isFetching: _isFetching,
          ),
        );
      },
      (data) {
        _roadmaps.addAll(data);
        if (data.length < _limit) {
          _canGetMore = false;
        }
        _isFetching = false;
        state = AsyncData(
          SavedRoadmapsState(
            roadmaps: _roadmaps,
            canGetMore: _canGetMore,
            isFetching: _isFetching,
          ),
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
