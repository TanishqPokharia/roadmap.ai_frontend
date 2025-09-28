import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_title_notifier.g.dart';

@riverpod
class PostTitle extends _$PostTitle {
  @override
  String build() {
    return '';
  }

  void setTitle(String value) {
    state = value;
  }
}
