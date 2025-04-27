import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

enum PinInputType { number, text, mixed }

class ResponsivePINInput extends StatefulWidget {
  final int pinLength;
  final TextEditingController? controller;
  final VoidCallback? onChanged;
  final String? errorText;
  final Color pinFillColor;
  final Color pinBorderColor;
  final Color pinActiveBorderColor;
  final PinInputType inputType;

  const ResponsivePINInput({
    super.key,
    this.pinLength = 6,
    this.controller,
    this.onChanged,
    this.errorText,
    this.pinFillColor = Colors.white,
    this.pinBorderColor = const Color.fromARGB(255, 182, 182, 182),
    this.pinActiveBorderColor = const Color.fromARGB(255, 54, 50, 159),
    this.inputType = PinInputType.mixed,
  });

  @override
  State<ResponsivePINInput> createState() => _ResponsivePINInputState();
}

class _ResponsivePINInputState extends State<ResponsivePINInput> {
  final FocusNode _focusNode = FocusNode();

  TextInputType get _keyboardType {
    switch (widget.inputType) {
      case PinInputType.number:
        return TextInputType.number;
      case PinInputType.text:
        return TextInputType.text;
      case PinInputType.mixed:
        return TextInputType.visiblePassword;
    }
  }

  List<TextInputFormatter> get _inputFormatters {
    switch (widget.inputType) {
      case PinInputType.number:
        return [FilteringTextInputFormatter.digitsOnly];
      case PinInputType.text:
        return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))];
      case PinInputType.mixed:
        return [];
    }
  }

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
          keyboardType: _keyboardType,
          inputFormatters: _inputFormatters,
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
            widget.onChanged?.call();
          },
          beforeTextPaste: (text) => false,
        ),
        if (widget.errorText != null)
          Transform.translate(
            offset: Offset(0, -10),
            child: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                widget.errorText!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}
