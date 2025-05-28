import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:flutter/services.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';

class TopUpDetailPage extends StatelessWidget {
  final String bankName;
  final String logoPath;
  final String vaNumber;
  final List<String> steps;

  const TopUpDetailPage({
    super.key,
    required this.bankName,
    required this.logoPath,
    required this.vaNumber,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Material(
            color: Colors.white,
            shape: const CircleBorder(),
            elevation: 2,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(12),
                elevation: 1,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      logoPath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: Offset(0, 8),
                        child: Text(
                          bankName,
                          style: const TextStyle(
                            fontSize: 35,
                            fontFamily: "Kalam",
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F1E5B),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -8),
                        child: Text(
                          bankName,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF9998CA),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // VA Number Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.copy,
                    size: isSmall ? 20 : 30,
                    color: Color(0xFF98A5FD),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "VIRTUAL ACCOUNT NO.",
                          style: TextStyle(
                            fontSize: isSmall ? 12 : 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          vaNumber,
                          style: TextStyle(
                            fontSize: isSmall ? 12 : 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      side: const BorderSide(color: Color(0xFF98A5FD)),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: vaNumber));
                      showFlexibleSnackbar(
                        context,
                        "VA successfully copied to clipboard!",
                      );
                    },
                    child: Text(
                      "Copy",
                      style: TextStyle(
                        fontSize: isSmall ? 12 : 14,
                        color: Color(0xFF98A5FD),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Instruction
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 235, 235, 235),
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(64),
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How to top up from $bankName:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmall ? 16 : 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "ADMIN FEE Rp2.500 – MIN. TOP UP Rp10.000",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 24, color: Colors.black),
                  SizedBox(height: 20),
                  MethodStepper(steps),
                  SizedBox(height: 50),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: ResponsiveButton(
                backgroundColor: const Color(0xFF1F1E5B),
                isSmall: isSmall,
                text: 'Back to home',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MethodStepper extends StatelessWidget {
  final List<String> steps;

  const MethodStepper(this.steps, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Column(
      children:
          steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == steps.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    if (index != 0)
                      Container(
                        width: 5,
                        height: 8,
                        color: const Color(0xFFD3D3F3),
                      ),
                    Container(
                      width: 40,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF98A5FD),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    // Line below
                    if (!isLast)
                      Container(
                        width: 5,
                        height: 20,
                        color: const Color(0xFFD3D3F3),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 14),
                    child: Text(
                      step,
                      style: TextStyle(
                        fontSize: isSmall ? 14 : 18,
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withAlpha(64),
                            blurRadius: 6,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }
}
