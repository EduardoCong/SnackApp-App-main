import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String body;
  final String buttonText;
  final VoidCallback onPressed;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.body,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Color.fromARGB(206, 31, 95, 7),
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        body,
        style: TextStyle(
          color: Color(0xFF000000),
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(206, 31, 95, 7),
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}



