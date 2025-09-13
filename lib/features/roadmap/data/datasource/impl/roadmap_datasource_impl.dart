import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/models/roadmap/roadmap.dart';
import 'package:roadmap_ai/core/common/dio/dio_provider.dart';
import 'package:roadmap_ai/core/utils/datasource_error_handler.dart';
import 'package:roadmap_ai/features/roadmap/data/datasource/interface/roadmap_datasource.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/http_error_handler.dart';

part 'roadmap_datasource_impl.g.dart';

@riverpod
RoadmapDatasource roadmapDatasource(Ref ref) {
  return RoadmapDatasourceImpl(ref.read(dioProvider));
}

class RoadmapDatasourceImpl implements RoadmapDatasource {
  final Dio _dio;
  RoadmapDatasourceImpl(this._dio);
  @override
  TaskEither<Failure, RoadmapModel> getGeneratedRoadmap(String description) {
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.get(
          '/roadmap/generate',
          queryParameters: {'topic': description},
        );
        if (response.statusCode != 200) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
        return RoadmapModel.fromJson(response.data['roadmap']);
      },
      (error, stackTrace) => dataSourceErrorHandler(
        error: error,
        message: 'GetGeneratedRoadmap failed',
      ),
    );
  }

  @override
  TaskEither<Failure, void> saveRoadmap(RoadmapModel roadmap) {
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.post(
          "/roadmap/save",
          data: roadmap.toJson(),
        );
        if (response.statusCode != 201) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
      },
      (error, stackTrace) => dataSourceErrorHandler(
        error: error,
        message: 'Could not save roadmap',
      ),
    );
  }
}
