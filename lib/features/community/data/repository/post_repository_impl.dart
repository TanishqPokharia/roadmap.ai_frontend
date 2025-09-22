import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/models/roadmap/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/features/community/data/datasource/impl/post_datasource_impl.dart';
import 'package:roadmap_ai/features/community/data/datasource/interface/post_datasource.dart';
import 'package:roadmap_ai/features/community/domain/repository/post_repository.dart';

part 'post_repository_impl.g.dart';

@riverpod
PostRepository postRepository(Ref ref) {
  final datasource = ref.read(postDatasourceProvider);
  return PostRepositoryImpl(datasource);
}

class PostRepositoryImpl implements PostRepository {
  final PostDatasource _datasource;

  PostRepositoryImpl(this._datasource);
  @override
  TaskEither<Failure, void> createPost({
    required Roadmap roadmap,
    required MultipartFile bannerImage,
  }) {
    return _datasource.createPost(
      roadmap: RoadmapModel.fromEntity(roadmap),
      bannerImage: bannerImage,
    );
  }
}
