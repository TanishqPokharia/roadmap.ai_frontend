import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/auth/data/repository/auth_repository_impl.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/no_params.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';

part 'is_user_logged_in.g.dart';

@Riverpod(keepAlive: true)
IsUserLoggedIn isUserLoggedIn(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return IsUserLoggedIn(repository);
}

class IsUserLoggedIn implements Usecase<NoParams, bool> {
  final AuthRepository _repository;
  IsUserLoggedIn(this._repository);
  @override
  TaskEither<Failure, bool> call(NoParams params) {
    if (kIsWeb) {
      return _repository.isLoggedInWeb();
    } else {
      return _repository.isLoggedInMobile();
    }
  }
}
