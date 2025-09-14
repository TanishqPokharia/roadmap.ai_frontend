import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fpdart/src/task_either.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';

class UpdateUserAvatar implements Usecase<UpdateUserAvatarParams, String> {
  final AuthRepository _authRepository;

  UpdateUserAvatar(this._authRepository);

  @override
  TaskEither<Failure, String> call(UpdateUserAvatarParams params) {
    if (params.image == null || params.image!.files.isEmpty) {
      return TaskEither.left(FilePickerFailure('No image selected'));
    }
    final file = params.image!.files.first;
    if (file.path == null) {
      return TaskEither.left(FilePickerFailure('Invalid file path'));
    }
    final multipartFile = MultipartFile.fromFileSync(
      file.path!,
      filename: file.name,
    );
    return _authRepository.updateAvatar(multipartFile);
  }
}

class UpdateUserAvatarParams {
  final FilePickerResult? image;

  UpdateUserAvatarParams({required this.image});
}
