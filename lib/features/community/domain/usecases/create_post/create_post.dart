import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/community/data/repository/post_repository_impl.dart';
import 'package:roadmap_ai/features/community/domain/repository/post_repository.dart';

part 'create_post.g.dart';

@riverpod
CreatePost createPost(Ref ref) {
  final repository = ref.read(postRepositoryProvider);
  return CreatePost(repository);
}

class CreatePost implements Usecase<CreatePostParams, void> {
  final PostRepository _repository;
  CreatePost(this._repository);

  @override
  TaskEither<Failure, void> call(CreatePostParams params) {
    return TaskEither.tryCatch(
      () async {
        if (params.bannerImage.files.isEmpty) {
          throw FilePickerFailure('No file selected');
        }
        final file = params.bannerImage.files.first;
        MultipartFile multipartFile;
        if (kIsWeb) {
          if (file.bytes == null) {
            throw FilePickerFailure('File bytes are not available on web');
          }
          multipartFile = MultipartFile.fromBytes(
            file.bytes!,
            filename: file.name,
          );
        } else {
          if (file.path == null) {
            throw FilePickerFailure(
              'File path is not available on mobile/desktop',
            );
          }
          multipartFile = await MultipartFile.fromFile(
            file.path!,
            filename: file.name,
          );
        }
        final result = await _repository
            .createPost(roadmap: params.roadmap, bannerImage: multipartFile)
            .run();
        return result.fold((failure) => throw failure, (success) => success);
      },
      (error, stackTrace) {
        if (error is Failure) return error;
        return UnknownFailure(error.toString());
      },
    );
  }
}

class CreatePostParams {
  final Roadmap roadmap;
  final FilePickerResult bannerImage;

  CreatePostParams({required this.roadmap, required this.bannerImage});
}
