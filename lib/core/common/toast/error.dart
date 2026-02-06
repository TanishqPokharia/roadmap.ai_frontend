import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:toastification/toastification.dart';

void showErrorToast({required BuildContext context, required String error}) {
  final textTheme = context.textTheme;
  final colorScheme = context.colorScheme;
  final isMobile = !kIsWeb && Platform.isAndroid;
  toastification.show(
    title: Text(
      'Error',
      style: isMobile
          ? textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)
          : textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
    ),
    description: Text(
      error,
      style: isMobile
          ? textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)
          : textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
    ),
    type: ToastificationType.error,
    backgroundColor: colorScheme.surface,
    borderSide: BorderSide(width: 2, color: colorScheme.onSurface),
    style: ToastificationStyle.minimal,
    foregroundColor: colorScheme.onSurface,
    borderRadius: BorderRadius.circular(10),
    autoCloseDuration: Duration(seconds: 2),
    margin: isMobile ? EdgeInsets.only(left: 60, top: 10, right: 10) : null,

    showProgressBar: true,
    showIcon: true,
  );
}
