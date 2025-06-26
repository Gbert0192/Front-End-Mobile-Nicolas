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
  bool barrierDismissible = true,
  Color color = const Color(0xFF1F1E5B),
}) {
  final size = MediaQuery.of(context).size;
  final isSmall = size.height < 700;

  showGeneralDialog(
    context: context,
    barrierLabel: "Dialog",
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final scaleAnimation = Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.elasticOut));

      final fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

      bool isLoading = false;

      return ScaleTransition(
        scale: scaleAnimation,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.symmetric(
                  horizontal: isSmall ? 24 : 32,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 32,
                        offset: const Offset(0, 16),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(isSmall ? 20 : 28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null)
                          Container(
                            width: isSmall ? 64 : 72,
                            height: isSmall ? 64 : 72,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  color.withValues(alpha: 0.15),
                                  color.withValues(alpha: 0.08),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: color.withValues(alpha: 0.1),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              icon,
                              size: isSmall ? 28 : 32,
                              color: color,
                            ),
                          ),
                        SizedBox(
                          height: icon != null ? (isSmall ? 20 : 24) : 0,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: isSmall ? 20 : 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A1A),
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: isSmall ? 8 : 12),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isSmall ? 15 : 16,
                            color: const Color(0xFF666666),
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: isSmall ? 28 : 32),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: isSmall ? 48 : 52,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFFE5E5E5),
                                    width: 1.5,
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap:
                                        isLoading
                                            ? null
                                            : () => Navigator.pop(context),
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        cancelText,
                                        style: TextStyle(
                                          fontSize: isSmall ? 15 : 16,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              isLoading
                                                  ? const Color(0xFFB0B0B0)
                                                  : const Color(0xFF333333),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                height: isSmall ? 48 : 52,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors:
                                        isLoading
                                            ? [
                                              color.withValues(alpha: 0.6),
                                              color.withValues(alpha: 0.4),
                                            ]
                                            : [
                                              color,
                                              Color.lerp(
                                                    color,
                                                    Colors.black,
                                                    0.1,
                                                  ) ??
                                                  color,
                                            ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow:
                                      isLoading
                                          ? []
                                          : [
                                            BoxShadow(
                                              color: color.withValues(
                                                alpha: 0.3,
                                              ),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap:
                                        isLoading
                                            ? null
                                            : () {
                                              if (loading) {
                                                setState(
                                                  () => isLoading = true,
                                                );
                                                Future.delayed(
                                                  Duration(seconds: time),
                                                  () {
                                                    if (onContinue != null) {
                                                      onContinue();
                                                    }
                                                    setState(
                                                      () => isLoading = false,
                                                    );
                                                  },
                                                );
                                              } else {
                                                if (onContinue != null) {
                                                  onContinue();
                                                }
                                              }
                                            },
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child:
                                          isLoading
                                              ? SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2.5,
                                                      color: Colors.white,
                                                      strokeCap:
                                                          StrokeCap.round,
                                                    ),
                                              )
                                              : Text(
                                                continueText,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: isSmall ? 15 : 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

void showAlertDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  IconData? icon,
  Color color = Colors.blueAccent,
  String buttonText = "OK",
  VoidCallback? onPressed,
  bool barrierDismissible = true,
}) {
  final size = MediaQuery.of(context).size;
  final isSmall = size.height < 700;
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder:
        (context) => AlertDialog(
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: Colors.black.withValues(alpha: 0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          titlePadding: EdgeInsets.fromLTRB(
            isSmall ? 24 : 20,
            24,
            isSmall ? 24 : 20,
            8,
          ),
          contentPadding: EdgeInsets.fromLTRB(
            isSmall ? 24 : 20,
            0,
            isSmall ? 24 : 20,
            16,
          ),
          actionsPadding: EdgeInsets.fromLTRB(
            isSmall ? 16 : 14,
            8,
            isSmall ? 16 : 14,
            16,
          ),
          title: Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, color: color, size: isSmall ? 30 : 45),
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
                        fontSize: isSmall ? 16 : 20,
                        color: color,
                      ),
                    ),
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
                backgroundColor: color,
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
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: isSmall ? 14 : 16,
                ),
              ),
            ),
          ],
        ),
  );
}
