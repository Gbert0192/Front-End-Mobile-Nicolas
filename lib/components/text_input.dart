import 'package:flutter/material.dart';

enum TextInputTypes { password, email, text }

class ResponsiveTextInput extends StatefulWidget {
  const ResponsiveTextInput({super.key, 
    required this.isSmall,
    this.controller,
    this.onChanged,
    this.hint,
    this.label,
    this.errorText,
    this.type = TextInputTypes.text,
    this.fillColor = Colors.white,
    this.borderColor = const Color(0xFF1F1E5B),
    this.borderFocusColor = const Color(0xFF505050),
  });

  final bool isSmall;
  final TextEditingController? controller;
  final VoidCallback? onChanged;
  final String? hint;
  final String? label;
  final String? errorText;
  final TextInputTypes type;
  final Color fillColor;
  final Color borderColor;
  final Color borderFocusColor;

  @override
  State<ResponsiveTextInput> createState() => _ResponsiveTextInputState();
}

class _ResponsiveTextInputState extends State<ResponsiveTextInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  Color _getColor() {
    if (widget.errorText != null) return Colors.red;
    if (_isFocused) return widget.borderColor;
    return widget.borderFocusColor;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    final isPassword = widget.type == TextInputTypes.password;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            obscureText: isPassword ? _obscureText : false,
            keyboardType:
                widget.type == TextInputTypes.email
                    ? TextInputType.emailAddress
                    : TextInputType.text,
            onChanged: (_) {
              widget.onChanged?.call();
            },
            decoration: InputDecoration(
              hintText: widget.hint ?? '',
              labelText: widget.label ?? '',
              hintStyle: TextStyle(color: _getColor()),
              labelStyle: TextStyle(color: _getColor()),
              floatingLabelStyle: TextStyle(color: _getColor()),
              filled: true,
              fillColor: hasError ? const Color(0xFFFFEDED) : widget.fillColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: widget.isSmall ? 18 : 20,
                vertical: widget.isSmall ? 12 : 16,
              ),
              suffixIcon:
                  isPassword
                      ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: _getColor(),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                      : null,
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
        const SizedBox(height: 4),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: widget.isSmall ? 12 : 16,
              ),
            ),
          ),
      ],
    );
  }
}
