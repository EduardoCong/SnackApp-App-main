import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton(
      {super.key, this.buttonText, this.onTap, this.color, this.textColor});
  final String? buttonText;
  final Widget? onTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (e) => onTap!,
          ),
        );
      },
      child: Container(
      width: 10,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color!,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(Icons.arrow_forward_rounded, color: Colors.black,),
      ),
    );
  }
}
