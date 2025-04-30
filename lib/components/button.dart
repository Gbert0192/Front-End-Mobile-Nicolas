import 'package:flutter/material.dart';

enum ButtonTypes { normal, outline }

class ResponsiveButton extends StatelessWidget {
  final bool isSmall;
  final VoidCallback? onPressed;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final ButtonTypes buttonType;
  final Color borderColor;
  final bool isLoading;

  const ResponsiveButton({super.key, 
    required this.isSmall,
    this.onPressed,
    required this.text,
    Color? textColor,
    this.buttonType = ButtonTypes.normal,
    this.backgroundColor = const Color(0xFF1F1E5B),
    this.borderColor = Colors.black,
    this.isLoading = false,
  }) : textColor =
           textColor ??
           (buttonType == ButtonTypes.normal ? Colors.white : Colors.black);

  @override
  Widget build(BuildContext context) {
    final buttonChild =
        isLoading
            ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: isSmall ? 16 : 24,
                  height: isSmall ? 16 : 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "Loading...",
                  style: TextStyle(
                    color: textColor,
                    fontSize: isSmall ? null : 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
            : Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: isSmall ? null : 20,
                fontWeight: FontWeight.w400,
              ),
            );

    final style = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    );

    final outlineStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      side: BorderSide(color: borderColor),
    );

    return SizedBox(
      width: isSmall ? 240 : 300,
      height: isSmall ? null : 50,
      child:
          buttonType == ButtonTypes.outline
              ? OutlinedButton(
                onPressed: isLoading ? null : onPressed,
                style: outlineStyle,
                child: buttonChild,
              )
              : ElevatedButton(
                onPressed: isLoading ? null : onPressed,
                style: style,
                child: buttonChild,
              ),
    );
  }
}
