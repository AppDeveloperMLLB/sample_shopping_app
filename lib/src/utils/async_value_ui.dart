import 'package:sample_shopping_app/src/common_widgets/alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context,
      {VoidCallback? callback}) async {
    if (!isRefreshing && hasError) {
      await showExceptionAlertDialog(
        context: context,
        title: 'Error',
        exception: error,
      );
      callback?.call();
    }
  }
}
