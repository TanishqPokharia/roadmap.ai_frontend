import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/constants/constants.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:toastification/toastification.dart';

void showSuccessToast({
  required BuildContext context,
  required String success,
}) {
  final textTheme = context.textTheme;
  final colorScheme = context.colorScheme;
  final isMobile = AppConstants.isAndroid;
  toastification.show(
    title: Text(
      'Success',
      style: isMobile
          ? textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            )
          : textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
    ),
    description: Text(
      success,
      style: isMobile
          ? textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)
          : textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
    ),
    type: ToastificationType.success,
    backgroundColor: colorScheme.surface,
    primaryColor: colorScheme.primary,
    borderSide: BorderSide(width: 2, color: colorScheme.onSurface),
    style: ToastificationStyle.minimal,
    foregroundColor: colorScheme.onSurface,
    borderRadius: BorderRadius.circular(10),
    margin: isMobile ? EdgeInsets.only(left: 60, top: 10, right: 10) : null,
    autoCloseDuration: Duration(seconds: 2),
    showProgressBar: true,
    showIcon: true,
  );
}
