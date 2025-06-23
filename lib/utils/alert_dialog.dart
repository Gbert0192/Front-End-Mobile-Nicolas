import 'package:flutter/material.dart';

void showConfirmDialog({
  required BuildContext context,
  bool loading = false,
  int time = 2,
  IconData? icon,
  String cancelText = "Cancel",
  String continueText = "Sure",
  String title = "Confirm",
  String subtitle = "Are you sure?",
  VoidCallback? onContinue,
  Color color = const Color(0xFF1F1E5B),
}) {
  final size = MediaQuery.of(context).size;
  final isSmall = size.height < 700;

  showGeneralDialog(
    context: context,
    barrierLabel: "Dialog",
    barrierDismissible: true,
    barrierColor: Colors.black.withAlpha(128),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      );

      bool isLoading = false;

      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              insetPadding: EdgeInsets.symmetric(horizontal: isSmall ? 35 : 30),
              child: Padding(
                padding:
                    isSmall
                        ? EdgeInsets.symmetric(vertical: 15, horizontal: 30)
                        : EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null)
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: color.withAlpha(42),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          icon,
                          size: isSmall ? 40 : 50,
                          color: color,
                        ),
                      ),
                    SizedBox(height: icon != null ? (isSmall ? 15 : 20) : 0),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isSmall ? 18 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: isSmall ? 8 : 10),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmall ? 14 : 18,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: isSmall ? 20 : 30),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed:
                                isLoading ? null : () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.grey),
                              padding: EdgeInsets.symmetric(
                                vertical: isSmall ? 10 : 14,
                              ),
                            ),
                            child: Text(
                              cancelText,
                              style: TextStyle(fontSize: isSmall ? null : 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                            onPressed:
                                isLoading
                                    ? null
                                    : () {
                                      if (loading) {
                                        setState(() => isLoading = true);
                                        Future.delayed(
                                          Duration(seconds: time),
                                          () {
                                            if (onContinue != null) {
                                              onContinue();
                                            }
                                            setState(() => isLoading = false);
                                          },
                                        );
                                      } else {
                                        if (onContinue != null) {
                                          onContinue();
                                        }
                                      }
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: color,
                              padding: EdgeInsets.symmetric(
                                vertical: isSmall ? 10 : 14,
                              ),
                            ),
                            child:
                                isLoading
                                    ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                    : Text(
                                      continueText,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isSmall ? null : 16,
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

void showAlertDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  String? subtitle,
  IconData? icon,
  Color? iconColor,
  Color? titleColor,
  Color? backgroundColor,
  Color? buttonColor,
  String buttonText = "OK",
  VoidCallback? onPressed,
  bool barrierDismissible = true,
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder:
        (context) => AlertDialog(
          backgroundColor: backgroundColor ?? Colors.white,
          elevation: 3,
          shadowColor: Colors.black.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          title: Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (iconColor ?? Colors.orange).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? Colors.orange,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: titleColor ?? Colors.grey.shade800,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          content: content,
          actions: [
            TextButton(
              onPressed: onPressed ?? () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: buttonColor ?? const Color(0xFF1F1E5B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
  );
}
