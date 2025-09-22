import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/dio/dio_provider.dart';
import 'package:roadmap_ai/core/common/models/roadmap/roadmap.dart';
import 'package:roadmap_ai/core/utils/datasource_error_handler.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/http_error_handler.dart';
import 'package:roadmap_ai/features/community/data/datasource/interface/post_datasource.dart';
import 'package:roadmap_ai/features/community/data/models/post_metadata/post_metadata.dart';
import 'package:roadmap_ai/features/community/data/models/user_post_stats/user_post_stats.dart';

part 'post_datasource_impl.g.dart';

@riverpod
PostDatasource postDatasource(Ref ref) {
  final dio = ref.read(dioProvider);
  return PostDatasourceImpl(dio);
}

class PostDatasourceImpl implements PostDatasource {
  final Dio _dio;

  PostDatasourceImpl(this._dio);
  @override
  TaskEither<Failure, void> createPost({
    required RoadmapModel roadmap,
    required MultipartFile bannerImage,
  }) {
    return TaskEither.tryCatch(
      () async {
        final roadmapJsonString = jsonEncode(roadmap.toJson());
        final formData = FormData.fromMap({
          'roadmap': roadmapJsonString,
          'bannerImage': bannerImage,
        });

        final response = await _dio.post(
          '/post',
          data: formData,
          options: Options(contentType: 'multipart/form-data'),
        );

        if (response.statusCode != 201) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
        return;
      },
      (error, stackTrace) =>
          dataSourceErrorHandler(error: error, message: 'Creating post failed'),
    );
  }

  @override
  TaskEither<Failure, List<PostMetadataModel>> getUserPostsMetaData({
    int limit = 10,
    int skip = 0,
  }) {
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.get(
          '/post/user',
          queryParameters: {'limit': limit, 'skip': skip},
        );

        if (response.statusCode != 200) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }

        final data = response.data;
        final List<dynamic> posts = data['posts'];
        final result = posts
            .map(
              (postJson) =>
                  PostMetadataModel.fromJson(postJson as Map<String, dynamic>),
            )
            .toList();
        return result;
      },
      (error, stackTrace) => dataSourceErrorHandler(
        error: error,
        message: 'Fetching posts failed',
      ),
    );
  }

  @override
  TaskEither<Failure, UserPostStatsModel> getUserPostStats() {
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.get('/post/stats');

        if (response.statusCode != 200) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }

        final data = response.data;
        final stats = UserPostStatsModel.fromJson(data);
        return stats;
      },
      (error, stackTrace) => dataSourceErrorHandler(
        error: error,
        message: 'Fetching user post stats failed',
      ),
    );
  }
}
