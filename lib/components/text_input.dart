import 'package:flutter/material.dart';

class ResponsiveTextInput extends StatefulWidget {
  const ResponsiveTextInput({
    this.controller,
    required this.onChanged,
    this.hint,
    this.label,
    this.type = 'text',
    this.minLength,
    this.maxLength,
    this.isRequired = false,
  });

  final TextEditingController? controller;
  final VoidCallback onChanged;
  final String? hint;
  final String? label;
  final String type;
  final int? minLength;
  final int? maxLength;
  final bool isRequired;

  @override
  State<ResponsiveTextInput> createState() => _ResponsiveTextInputState();
}

class _ResponsiveTextInputState extends State<ResponsiveTextInput> {
  late FocusNode _focusNode;
  String? _errorText;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
        if (!_isFocused) _validate();
      });
    });
  }

  void _validate() {
    final value = widget.controller?.text ?? '';
    String? error;

    if (widget.isRequired && value.isEmpty) {
      error = 'This field is required';
    } else if (widget.type == 'email' && value.isNotEmpty) {
      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
      if (!emailRegex.hasMatch(value)) {
        error = 'Invalid email format';
      }
    } else if (widget.minLength != null && value.length < widget.minLength!) {
      error = 'Minimum ${widget.minLength} characters required';
    } else if (widget.maxLength != null && value.length > widget.maxLength!) {
      error = 'Maximum ${widget.maxLength} characters allowed';
    }

    setState(() {
      _errorText = error;
    });
  }

  Color _getColor() {
    if (_errorText != null) return Colors.red;
    if (_isFocused) return const Color(0xFF1F1E5B);
    return const Color(0xFFAEB3BA);
  }

  @override
  Widget build(BuildContext context) {
    final hasError = _errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: TextField(
                focusNode: _focusNode,
                controller: widget.controller,
                obscureText: widget.type == 'password',
                keyboardType:
                    widget.type == 'email'
                        ? TextInputType.emailAddress
                        : TextInputType.text,
                onChanged: (_) {
                  _validate();
                  onChanged();
                },
                decoration: InputDecoration(
                  hintText: widget.hint ?? '',
                  labelText: widget.label ?? '',
                  hintStyle: TextStyle(color: _getColor()),
                  labelStyle: TextStyle(color: _getColor()),
                  floatingLabelStyle: TextStyle(color: _getColor()),
                  errorText:
                      null, // << penting, biar gak pakai default error padding
                  filled: true,
                  fillColor: hasError ? const Color(0xFFFFEDED) : Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _getColor(), width: 2.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _getColor()),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              _errorText ?? '',
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
