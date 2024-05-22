import 'package:flutter/material.dart';

class SnackBarCustom {
  final String message;
  final BuildContext context;

  const SnackBarCustom({
    required this.context,
    required this.message,
  });

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Durations.long4 * 3,
    ));
  }
}
