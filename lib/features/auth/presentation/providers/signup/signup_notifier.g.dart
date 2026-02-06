// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SignupNotifier)
final signupProvider = SignupNotifierProvider._();

final class SignupNotifierProvider
    extends $AsyncNotifierProvider<SignupNotifier, SignUpState> {
  SignupNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signupNotifierHash();

  @$internal
  @override
  SignupNotifier create() => SignupNotifier();
}

String _$signupNotifierHash() => r'f421e00105d37c60c1e93528d547f0411adafd83';

abstract class _$SignupNotifier extends $AsyncNotifier<SignUpState> {
  FutureOr<SignUpState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SignUpState>, SignUpState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SignUpState>, SignUpState>,
              AsyncValue<SignUpState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
