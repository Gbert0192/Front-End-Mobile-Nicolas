import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextInputTypes { password, email, text, number }

enum StyleMode { outline, underline }

class ResponsiveTextInput extends StatefulWidget {
  const ResponsiveTextInput({
    super.key,
    required this.isSmall,
    this.readOnly = false,
    this.controller,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.hint,
    this.label,
    this.errorText,
    this.leading,
    this.disabled,
    this.suffix,
    this.value,
    this.mode = StyleMode.outline,
    this.maxLines = 1,
    this.type = TextInputTypes.text,
    this.fillColor = Colors.white,
    this.borderColor = const Color(0xFF1F1E5B),
    this.borderFocusColor = const Color(0xFF505050),
  });

  final bool isSmall;
  final bool readOnly;
  final int maxLines;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final Function(String)? onSubmitted;
  final String? hint;
  final String? label;
  final String? value;
  final String? errorText;
  final StyleMode mode;
  final TextInputTypes type;
  final IconData? leading;
  final bool? disabled;
  final Widget? suffix;
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
        widget.mode == StyleMode.underline
            ? Text(
              widget.label!,
              style: TextStyle(
                color: _getColor(),
                fontSize: widget.isSmall ? 12 : 16,
              ),
            )
            : SizedBox.shrink(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow:
                widget.mode == StyleMode.underline
                    ? null
                    : [
                      BoxShadow(
                        color: Colors.black.withAlpha(64),
                        blurRadius: 6,
                        offset: const Offset(4, 4),
                      ),
                    ],
          ),
          child: TextField(
            enabled: widget.disabled != null ? !widget.disabled! : true,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines,
            focusNode: _focusNode,
            controller: widget.controller,
            obscureText: isPassword ? _obscureText : false,
            keyboardType:
                widget.type == TextInputTypes.email
                    ? TextInputType.emailAddress
                    : widget.type == TextInputTypes.number
                    ? TextInputType.number
                    : TextInputType.text,
            onChanged: (value) {
              widget.onChanged?.call(value);
            },
            onTap: () {
              widget.onTap?.call();
            },
            onSubmitted: (value) {
              widget.onSubmitted?.call(value);
            },
            decoration: InputDecoration(
              hintText: widget.hint,
              labelText:
                  widget.mode == StyleMode.underline ? null : widget.label,
              hintStyle: TextStyle(color: _getColor()),
              labelStyle: TextStyle(color: _getColor()),
              floatingLabelStyle: TextStyle(color: _getColor()),
              filled: true,
              fillColor:
                  widget.mode == StyleMode.underline
                      ? Colors.white
                      : hasError
                      ? const Color(0xFFFFEDED)
                      : widget.fillColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: widget.isSmall ? 18 : 20,
                vertical: widget.isSmall ? 12 : 16,
              ),
              prefixIcon:
                  widget.leading != null
                      ? Icon(widget.leading, size: widget.isSmall ? 20 : 28)
                      : null,
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
                      : widget.suffix,
              border:
                  widget.mode == StyleMode.underline
                      ? UnderlineInputBorder()
                      : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
              focusedBorder:
                  widget.mode == StyleMode.underline
                      ? UnderlineInputBorder(
                        borderSide: BorderSide(color: _getColor(), width: 2.0),
                      )
                      : OutlineInputBorder(
                        borderSide: BorderSide(color: _getColor(), width: 2.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
              enabledBorder:
                  widget.mode == StyleMode.underline
                      ? UnderlineInputBorder(
                        borderSide: BorderSide(color: _getColor()),
                      )
                      : OutlineInputBorder(
                        borderSide: BorderSide(color: _getColor()),
                        borderRadius: BorderRadius.circular(20),
                      ),
              errorBorder:
                  widget.mode == StyleMode.underline
                      ? UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                      )
                      : OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(20),
                      ),
            ),
            inputFormatters:
                widget.type == TextInputTypes.number
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : null,
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
                fontSize: widget.isSmall ? 12 : 15,
              ),
            ),
          ),
      ],
    );
  }
}
