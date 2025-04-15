import 'package:flutter/material.dart';

class ResponsiveButton extends StatelessWidget {
  final bool isSmall;
  final VoidCallback? onPressed;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final String buttonType;
  final Color borderColor;

  const ResponsiveButton({
    required this.isSmall,
    this.onPressed,
    required this.text,
    Color? textColor,
    this.buttonType = "normal",
    this.backgroundColor = const Color(0xFF1F1E5B),
    this.borderColor = Colors.black,
  }) : textColor =
           textColor ?? (buttonType == "normal" ? Colors.white : Colors.black);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isSmall ? 240 : 300,
      height: isSmall ? null : 50,
      child:
          buttonType == "outline"
              ? OutlinedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  side: BorderSide(color: borderColor),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: isSmall ? null : 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
              : ElevatedButton(
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
