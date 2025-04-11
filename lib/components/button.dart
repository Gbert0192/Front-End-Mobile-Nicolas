import 'package:flutter/material.dart';

class ResponsiveButton extends StatelessWidget {
  final bool isSmall;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final Color backgroundColor;

  const ResponsiveButton({
    Key? key,
    required this.isSmall,
    required this.onPressed,
    required this.text,
    this.textColor = Colors.white,
    this.backgroundColor = const Color(0xFF1F1E5B),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isSmall ? 240 : 300,
      height: isSmall ? null : 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: isSmall ? null : 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
