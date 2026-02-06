// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(logoutUser)
final logoutUserProvider = LogoutUserProvider._();

final class LogoutUserProvider
    extends $FunctionalProvider<LogoutUser, LogoutUser, LogoutUser>
    with $Provider<LogoutUser> {
  LogoutUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logoutUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logoutUserHash();

  @$internal
  @override
  $ProviderElement<LogoutUser> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LogoutUser create(Ref ref) {
    return logoutUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LogoutUser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LogoutUser>(value),
    );
  }
}

String _$logoutUserHash() => r'f7de1befbf4392f667240f5aa9694106cefcd90a';
