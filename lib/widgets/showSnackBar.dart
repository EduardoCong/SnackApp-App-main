import 'package:flutter/material.dart';

class SnackBarWidget{
  final String message;
  final Color backgroundColor;

  SnackBarWidget({required this.message, required this.backgroundColor});

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
      ),
    );
  }
}

