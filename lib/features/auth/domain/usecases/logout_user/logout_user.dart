import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/auth/data/repository/auth_repository_impl.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/no_params.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';

part 'logout_user.g.dart';

@riverpod
LogoutUser logoutUser(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUser(repository);
}

class LogoutUser implements Usecase<NoParams, void> {
  final AuthRepository _authRepository;
  LogoutUser(this._authRepository);
  @override
  TaskEither<Failure, void> call(NoParams params) {
    if (kIsWeb) {
      return _authRepository.logoutWeb();
    } else {
      return _authRepository.logoutMobile();
    }
  }
}
