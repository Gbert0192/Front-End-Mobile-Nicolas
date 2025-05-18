import 'package:flutter/material.dart';

void showAlertDialog({
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
    barrierColor: Colors.black.withOpacity(0.5),
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
                      Icon(icon, size: isSmall ? 40 : 50, color: color),
                    SizedBox(height: icon != null ? (isSmall ? 15 : 20) : 0),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isSmall ? 18 : 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: isSmall ? 8 : 10),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmall ? 14 : 16,
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
                            child: Text(cancelText),
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
                                      style: const TextStyle(
                                        color: Colors.white,
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
