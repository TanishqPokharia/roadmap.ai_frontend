import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/no_params.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/auth/data/repository/auth_repository_impl.dart';
import 'package:roadmap_ai/features/auth/domain/entities/user_details.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';

part 'get_user_details.g.dart';

@Riverpod(keepAlive: true)
GetUserDetails getUserDetails(Ref ref) {
  final repository = ref.read(authRepositoryProvider);
  return GetUserDetails(repository);
}

class GetUserDetails implements Usecase<NoParams, UserDetails> {
  final AuthRepository _repository;

  GetUserDetails(this._repository);
  @override
  TaskEither<Failure, UserDetails> call(NoParams params) {
    return _repository.getUserDetails();
  }
}
