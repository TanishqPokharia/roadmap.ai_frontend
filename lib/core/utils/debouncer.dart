import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  Debouncer({required this.duration});
  Timer? _timer;
  final Duration duration;

  void debounce(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }
}
