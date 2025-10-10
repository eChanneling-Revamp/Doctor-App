import 'package:flutter/material.dart';

/// Centralized helper for showing SnackBars.
///
/// Use `SnackbarUtils.show(context, 'message')` or the convenience methods
/// `success`, `error`, `info` for consistent styling.
class SnackbarUtils {
  SnackbarUtils._();

  static void show(
    BuildContext context,
    String message, {
    Duration? duration,
    Color? backgroundColor,
    SnackBarAction? action,
    SnackBarBehavior? behavior,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: duration ?? const Duration(seconds: 2),
      backgroundColor: backgroundColor,
      behavior: behavior ?? SnackBarBehavior.floating,
      action: action,
    );

    final messenger = ScaffoldMessenger.of(context);
    // Hide any current snackbar before showing a new one to avoid stacking.
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(snackBar);
  }

  static void success(
    BuildContext context,
    String message, {
    Duration? duration,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    show(
      context,
      message,
      duration: duration,
      backgroundColor: Colors.green[700],
      action:
          actionLabel != null
              ? SnackBarAction(label: actionLabel, onPressed: onAction ?? () {})
              : null,
    );
  }

  static void error(
    BuildContext context,
    String message, {
    Duration? duration,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    show(
      context,
      message,
      duration: duration,
      backgroundColor: Colors.red[700],
      action:
          actionLabel != null
              ? SnackBarAction(label: actionLabel, onPressed: onAction ?? () {})
              : null,
    );
  }

  static void info(
    BuildContext context,
    String message, {
    Duration? duration,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    show(
      context,
      message,
      duration: duration,
      backgroundColor: Colors.black87,
      action:
          actionLabel != null
              ? SnackBarAction(label: actionLabel, onPressed: onAction ?? () {})
              : null,
    );
  }
}
