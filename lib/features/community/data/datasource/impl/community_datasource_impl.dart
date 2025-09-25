import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/community/data/datasource/interface/community_datasource.dart';
import 'package:roadmap_ai/features/community/data/models/individualPost/individualPosts.dart';
import 'package:roadmap_ai/features/community/data/models/popularPosts/popularPosts.dart';

import '../../../../../core/common/dio/dio_provider.dart';
import '../../../../../core/common/token_storage/flutter_secure_storage_token_storage_impl.dart';
import '../../../../../core/common/token_storage/token_storage.dart';
import '../../../../../core/utils/datasource_error_handler.dart';
import '../../../../../core/utils/failures.dart';
import '../../../../../core/utils/http_error_handler.dart';
part 'community_datasource_impl.g.dart';
@riverpod
CommunityDatasource communityDatasource(Ref ref) {
  return CommunityDatasourceImpl(
    ref.read(dioProvider),
    ref.read(tokenStorageProvider),
  );
}


class CommunityDatasourceImpl implements CommunityDatasource {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  CommunityDatasourceImpl(this._dio, this._tokenStorage);


  @override
  TaskEither<Failure, PopularPostResponse> getPopularPost({
    required int limit, required int skip}) {
    return TaskEither.tryCatch(
          () async {
        final response = await _dio.post(
          '/post', queryParameters: {'limit': limit, 'skip': skip},
        );
        print(response);

        if (response.statusCode != 201 || response.statusCode != 200) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
        final data = response.data;
        return PopularPostResponse.fromJson(data);
      },
          (error, stackTrace) =>
          dataSourceErrorHandler(
            error: error,
            message: 'Fetching popular post failed',
          ),
    );
  }

  @override
  TaskEither<Failure, IndividualPostResponse> getIndividualPost(
      {required String postId}) {
    return TaskEither.tryCatch(
          () async {
        final response = await _dio.post(
          '/post/roadmap/$postId',
        );


        if (response.statusCode != 201 || response.statusCode != 200) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
        final data = response.data;
        return IndividualPostResponse.fromJson(data);
      },
          (error, stackTrace) =>
          dataSourceErrorHandler(
            error: error,
            message: 'Failed fetching individual post',
          ),
    );
  }
}