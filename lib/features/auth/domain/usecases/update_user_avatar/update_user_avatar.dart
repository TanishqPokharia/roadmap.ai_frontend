import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/auth/data/repository/auth_repository_impl.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';

part 'update_user_avatar.g.dart';

@Riverpod(keepAlive: true)
UpdateUserAvatar updateUserAvatar(Ref ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return UpdateUserAvatar(authRepository);
}

class UpdateUserAvatar implements Usecase<UpdateUserAvatarParams, String> {
  final AuthRepository _authRepository;

  UpdateUserAvatar(this._authRepository);

  @override
  TaskEither<Failure, String> call(UpdateUserAvatarParams params) {
    return TaskEither.tryCatch(
      () async {
        if (params.image == null || params.image!.files.isEmpty) {
          throw FilePickerFailure('No file selected');
        }
        final file = params.image!.files.first;
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
        final result = await _authRepository.updateAvatar(multipartFile).run();
        return result.fold(
          (failure) => throw failure,
          (avatarUrl) => avatarUrl,
        );
      },
      (error, stackTrace) {
        if (error is Failure) return error;
        return UnknownFailure(error.toString());
      },
    );
  }
}

class UpdateUserAvatarParams {
  final FilePickerResult? image;

  UpdateUserAvatarParams({required this.image});
}
