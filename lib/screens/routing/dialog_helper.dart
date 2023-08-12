import 'package:flutter/cupertino.dart';

void showAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  String defaultActionText = '取消',
  String destructiveActionText = '確認',
  VoidCallback? destructiveAction,
  VoidCallback? defaultAction,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <CupertinoDialogAction>[
        if (defaultAction != null)
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: defaultAction,
            child: Text(defaultActionText),
          ),
        if (destructiveAction != null)
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: destructiveAction,
            child: Text(destructiveActionText),
          ),
      ],
    ),
  );
}
