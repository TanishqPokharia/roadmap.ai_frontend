import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/models/roadmap/roadmap.dart';
import 'package:roadmap_ai/core/common/providers/dio_provider.dart';
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
      (error, stackTrace) {
        log('Roadmap generation failed', error: error, stackTrace: stackTrace);
        if (error is Failure) return error;
        if (error is DioException) {
          if (error.response != null) {
            return httpErrorHandler(error.response!.statusCode ?? 0);
          } else {
            return UnknownFailure(error.response.toString());
          }
        }

        return UnknownFailure(error.toString());
      },
    );
  }
}
