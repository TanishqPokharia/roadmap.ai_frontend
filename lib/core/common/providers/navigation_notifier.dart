import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_notifier.g.dart';

@Riverpod(keepAlive: true)
class NavigationNotifier extends _$NavigationNotifier {
  int _index = 0;
  @override
  int build() {
    ref.keepAlive();
    return _index;
  }

  void setSelectedIndex(int index) {
    _index = index;
    state = _index;
  }
}
