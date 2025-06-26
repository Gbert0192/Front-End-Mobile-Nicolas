import 'package:flutter/material.dart';

class ReceiptText extends StatelessWidget {
  final String left;
  final String right;
  final bool isRed;

  const ReceiptText({
    super.key,
    required this.left,
    required this.right,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            left,
            style: TextStyle(
              fontSize: 18,
              color: isRed ? Colors.red : const Color(0xFF818181),
            ),
          ),
          Flexible(
            child: Text(
              right,
              style: TextStyle(
                fontSize: 18,
                color: isRed ? Colors.red : Colors.black,
              ),

              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
