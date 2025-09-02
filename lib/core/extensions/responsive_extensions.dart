import 'package:flutter/material.dart';

extension ResponsivePadding on BuildContext {
  EdgeInsets get responsivePadding {
    if (MediaQuery.of(this).size.width < 600) {
      return const EdgeInsets.all(8.0);
    } else if (MediaQuery.of(this).size.width < 1200) {
      return const EdgeInsets.all(16.0);
    }
    return const EdgeInsets.all(32.0);
  }

  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}
