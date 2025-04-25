import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ResponsivePINInput extends StatefulWidget {
  final bool isSmall;
  final int pinLength;
  final TextEditingController? controller;
  final VoidCallback? onChanged;
  final String? errorText;
  final Color pinFillColor;
  final Color pinBorderColor;

  const ResponsivePINInput({
    required this.isSmall,
    this.pinLength = 6,
    this.controller,
    this.onChanged,
    this.errorText,
    this.pinFillColor = Colors.white,
    this.pinBorderColor = const Color.fromARGB(255, 182, 182, 182),
  });

  @override
  _ResponsivePINInputState createState() => _ResponsivePINInputState();
}

class _ResponsivePINInputState extends State<ResponsivePINInput> {
  bool isOtpEmpty = true;
  bool allFieldsFilled = false;

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor =
        widget.errorText != null ? Colors.red : widget.pinBorderColor;
    final Color effectiveFillColor =
        widget.errorText != null
            ? const Color(0xFFFFEDED)
            : widget.pinFillColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PinCodeTextField(
          appContext: context,
          length: widget.pinLength,
          controller: widget.controller,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 50,
            fieldWidth: 50,
            activeFillColor:
                isOtpEmpty ? const Color(0xFFFFEDED) : Colors.white,
            selectedFillColor:
                isOtpEmpty ? const Color(0xFFFFEDED) : Colors.white,
            inactiveFillColor:
                isOtpEmpty ? const Color(0xFFFFEDED) : Colors.white,
            activeColor: widget.errorText != null ? Colors.red : Colors.blue,
            selectedColor: widget.errorText != null ? Colors.red : Colors.blue,
            inactiveColor:
                widget.errorText != null
                    ? Colors.red
                    : const Color.fromARGB(255, 182, 182, 182),
          ),
          enableActiveFill: true,
          onChanged: (_) {
            widget.onChanged?.call();
          },
          beforeTextPaste: (text) {
            return false; // Disallow pasting
          },
          onTap: () {
            if (allFieldsFilled) {
              setState(() {
                widget.controller?.clear();
                isOtpEmpty = true;
                allFieldsFilled = false;
              });
            }
          },
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
