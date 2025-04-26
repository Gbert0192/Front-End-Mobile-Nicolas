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
  final Color pinActiveBorderColor;

  const ResponsivePINInput({
    super.key,
    required this.isSmall,
    this.pinLength = 6,
    this.controller,
    this.onChanged,
    this.errorText,
    this.pinFillColor = Colors.white,
    this.pinBorderColor = const Color.fromARGB(255, 182, 182, 182),
    this.pinActiveBorderColor = const Color.fromARGB(255, 54, 50, 159),
  });

  @override
  State<ResponsivePINInput> createState() => _ResponsivePINInputState();
}

class _ResponsivePINInputState extends State<ResponsivePINInput> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PinCodeTextField(
          appContext: context,
          length: widget.pinLength,
          controller: widget.controller,
          focusNode: _focusNode,
          autoDisposeControllers: false,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: 50,
            fieldWidth: 50,
            activeFillColor:
                widget.errorText != null
                    ? const Color(0xFFFFEDED)
                    : widget.pinFillColor,
            selectedFillColor:
                widget.errorText != null
                    ? const Color(0xFFFFEDED)
                    : widget.pinFillColor,
            inactiveFillColor:
                widget.errorText != null
                    ? const Color(0xFFFFEDED)
                    : widget.pinFillColor,
            activeColor:
                widget.errorText != null
                    ? Colors.red
                    : widget.pinActiveBorderColor,
            selectedColor:
                widget.errorText != null
                    ? Colors.red
                    : widget.pinActiveBorderColor,
            inactiveColor:
                widget.errorText != null ? Colors.red : widget.pinBorderColor,
            activeBoxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            inActiveBoxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          enableActiveFill: true,
          onChanged: (val) {
            widget.onChanged!();
          },
          beforeTextPaste: (text) => false,
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
