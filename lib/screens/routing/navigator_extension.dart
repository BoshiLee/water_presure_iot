import 'package:flutter/material.dart';

extension NavigatorExtension on Navigator {
  static Future<T?> navigateToNextPage<T extends Object?>(
    BuildContext context,
    Widget page,
    String pageId, {
    bool fullscreenDialog = false,
  }) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(name: pageId),
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  static void popToRoot(BuildContext context) {
    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
  }

  static void popToPrevious(BuildContext context, String pageId) {
    Navigator.popAndPushNamed(context, pageId);
  }
}
