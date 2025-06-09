import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';
import 'package:tugas_front_end_nicolas/model/user.dart';
import 'package:tugas_front_end_nicolas/provider/user_provider.dart';
import 'package:tugas_front_end_nicolas/screens/tabs/home/topup/topup.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';

enum MethodType { cash, transfer }

class TopUpDetailPage extends StatefulWidget {
  final MethodType? type;
  final TopUpMethod method;

  const TopUpDetailPage({super.key, required this.type, required this.method});

  @override
  State<TopUpDetailPage> createState() => _TopUpDetailPageState();
}

class _TopUpDetailPageState extends State<TopUpDetailPage> {
  final TextEditingController _amountController = TextEditingController();
  bool _isProcessing = false;
  bool _showSimulation = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final userProvider = Provider.of<UserProvider>(context);
    User user = userProvider.currentUser!;

    void showSuccessDialog(double originalAmount, double finalAmount) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: isSmall ? 25 : 30,
                ),
                SizedBox(width: 10),
                Text(
                  "Top-up Successful!",
                  style: TextStyle(fontSize: isSmall ? 20 : null),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Payment Method: ${widget.method.name}"),
                Text("Amount: ${formatCurrency(nominal: originalAmount)}"),
                if (widget.method.adminFee != null) ...[
                  Text(
                    "Admin Fee: ${formatCurrency(nominal: widget.method.adminFee as num)}",
                  ),
                  Divider(),
                  Text(
                    "Credit Added: ${formatCurrency(nominal: finalAmount)}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }

    Future<void> simulateTopUp() async {
      if (_amountController.text.isEmpty) {
        showFlexibleSnackbar(
          context,
          "Please enter an amount",
          type: SnackbarType.error,
        );
        return;
      }

      final amount = double.tryParse(
        _amountController.text.replaceAll(',', ''),
      );
      if (amount == null || amount <= 0) {
        showFlexibleSnackbar(
          context,
          "Please enter a valid amount",
          type: SnackbarType.error,
        );
        return;
      }

      if (amount < widget.method.minTo!) {
        showFlexibleSnackbar(
          context,
          "Minimum top-up is ${formatCurrency(nominal: widget.method.minTo as num)}",
        );
        return;
      }

      setState(() {
        _isProcessing = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      final finalAmount =
          widget.method.adminFee != null
              ? amount - (widget.method.adminFee as double)
              : amount;

      userProvider.topUp(finalAmount);

      setState(() {
        _isProcessing = false;
      });

      showSuccessDialog(amount, finalAmount);
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
            floating: true,
            snap: true,
            actions: [
              IconButton(
                icon: Icon(
                  _showSimulation ? Icons.visibility_off : Icons.play_arrow,
                ),
                onPressed: () {
                  setState(() {
                    _showSimulation = !_showSimulation;
                  });
                },
                tooltip: _showSimulation ? "Hide Simulation" : "Test Top-up",
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Method header
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(bottom: isSmall ? 10 : 16),
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
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          widget.method.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Transform.translate(
                            offset: Offset(0, isSmall ? 6 : 10),
                            child: Text(
                              widget.method.name.toUpperCase(),
                              style: TextStyle(
                                fontSize: isSmall ? 30 : 35,
                                fontFamily: "Kalam",
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F1E5B),
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, isSmall ? -6 : -6),
                            child: Text(
                              widget.method.name.toUpperCase(),
                              style: TextStyle(
                                fontSize: isSmall ? 14 : 18,
                                color: Color.fromARGB(255, 83, 81, 203),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Simulation Panel (when enabled)
                if (_showSimulation) ...[
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      border: Border.all(color: Colors.orange.shade200),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.science, color: Colors.orange),
                            SizedBox(width: 8),
                            Text(
                              "SIMULATION MODE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange.shade800,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Enter amount to simulate top-up (min ${formatCurrency(nominal: widget.method.minTo as num)}):",
                        ),
                        SizedBox(height: 8),
                        ResponsiveTextInput(
                          isSmall: isSmall,
                          hint: "Enter amount",
                          type: TextInputTypes.number,
                          controller: _amountController,
                          leading: Icons.attach_money,
                          fillColor: Colors.white,
                        ),
                        SizedBox(height: 12),
                        ResponsiveButton(
                          isSmall: isSmall,
                          backgroundColor: const Color.fromARGB(
                            220,
                            81,
                            119,
                            255,
                          ),
                          isLoading: _isProcessing,
                          onPressed: _isProcessing ? null : simulateTopUp,
                          text: "Simulate Top-up",
                          loadingText: "Processing...",
                        ),
                      ],
                    ),
                  ),
                ],

                // VA Number / Barcode Section
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: widget.type == MethodType.transfer ? 12 : 0,
                  ),
                  margin: EdgeInsets.only(bottom: isSmall ? 10 : 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (widget.type == MethodType.transfer) ...[
                              Row(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "VIRTUAL ACCOUNT NO.",
                                          style: TextStyle(
                                            fontSize: isSmall ? 12 : 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          "${widget.method.prefix}${user.phone}",
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
                                      side: const BorderSide(
                                        color: Color(0xFF98A5FD),
                                      ),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                          text:
                                              "${widget.method.prefix}${user.phone}",
                                        ),
                                      );
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
                            ] else ...[
                              Text(
                                "Show the cashier this barcode",
                                style: TextStyle(
                                  fontSize: isSmall ? 12 : 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                              BarcodeWidget(
                                barcode: Barcode.code128(),
                                data: "${widget.method.prefix}${user.phone}",
                                width: 250,
                                height: 75,
                                drawText: true,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Instructions
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmall ? 10 : 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "How to top up from ${widget.method.name}:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: isSmall ? 16 : 20,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${widget.method.adminFee != null ? "ADMIN FEE ${formatCurrency(nominal: widget.method.adminFee as num)} – " : ""}MIN. TOP UP ${formatCurrency(nominal: widget.method.minTo as num)}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: isSmall ? 12 : 24, color: Colors.black),
                      SizedBox(height: isSmall ? 10 : 20),
                      MethodStepper(widget.method.steps),
                      SizedBox(height: isSmall ? 25 : 50),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
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
                        height: isSmall ? 3 : 8,
                        color: const Color(0xFFD3D3F3),
                      ),
                    Container(
                      width: isSmall ? 30 : 40,
                      height: isSmall ? 40 : 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF98A5FD),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: isSmall ? 15 : 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 5,
                        height: isSmall ? 12 : 20,
                        color: const Color(0xFFD3D3F3),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: isSmall ? 10 : 14),
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
