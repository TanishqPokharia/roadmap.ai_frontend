import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/auth/domain/usecases/logout_user/logout_user.dart';
import 'package:roadmap_ai/core/utils/no_params.dart';

part 'logout_notifier.g.dart';

enum LogoutState { initial, success }

@riverpod
class LogoutNotifier extends _$LogoutNotifier {
  @override
  FutureOr<LogoutState> build() {
    return LogoutState.initial;
  }

  void logout() async {
    state = AsyncLoading();
    final logoutResult = await ref
        .read(logoutUserProvider)
        .call(NoParams())
        .run();
    logoutResult.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (r) {
        state = const AsyncData(LogoutState.success);
      },
    );
  }
}
