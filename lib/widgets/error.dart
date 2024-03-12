import 'package:flutter/material.dart';

class ErrorSnackbar {
  void showError(BuildContext context, String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(
          value,
          textScaler: TextScaler.noScaling,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onError,
          ),
        ),
      ),
    );
  }
}
