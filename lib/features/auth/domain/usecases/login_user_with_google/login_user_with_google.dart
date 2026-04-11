import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/token_storage/flutter_secure_storage_token_storage_impl.dart';
import 'package:roadmap_ai/core/common/token_storage/token_storage.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/auth/data/repository/auth_repository_impl.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';
part 'login_user_with_google.g.dart';

@riverpod
LoginUserWithGoogle loginUserWihGoogle(Ref ref) {
  final authRepository = ref.read(authRepositoryProvider);
  final tokenStorage = ref.read(tokenStorageProvider);

  return LoginUserWithGoogle(authRepository, tokenStorage);
}

class LoginUserWithGoogle implements Usecase<LoginUserWithGoogleParams, void> {
  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;

  LoginUserWithGoogle(this._authRepository, this._tokenStorage);
  @override
  TaskEither<Failure, void> call(LoginUserWithGoogleParams params) {
    final tokens = _authRepository.loginMobileWithGoogle(
      googleIdToken: params.googleIdToken,
    );

    return tokens.flatMap(
      (tokens) => _tokenStorage.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      ),
    );
  }
}

class LoginUserWithGoogleParams {
  final String googleIdToken;

  LoginUserWithGoogleParams({required this.googleIdToken});
}
