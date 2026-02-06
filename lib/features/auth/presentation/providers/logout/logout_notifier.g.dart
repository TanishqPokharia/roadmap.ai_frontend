// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LogoutNotifier)
final logoutProvider = LogoutNotifierProvider._();

final class LogoutNotifierProvider
    extends $AsyncNotifierProvider<LogoutNotifier, LogoutState> {
  LogoutNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logoutProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logoutNotifierHash();

  @$internal
  @override
  LogoutNotifier create() => LogoutNotifier();
}

String _$logoutNotifierHash() => r'181b6f094367e304dc05357d446e56ed509540df';

abstract class _$LogoutNotifier extends $AsyncNotifier<LogoutState> {
  FutureOr<LogoutState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LogoutState>, LogoutState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LogoutState>, LogoutState>,
              AsyncValue<LogoutState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
