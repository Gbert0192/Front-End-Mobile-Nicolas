import 'package:flutter/material.dart';

class ResponsiveDropdown<T> extends StatefulWidget {
  const ResponsiveDropdown({
    super.key,
    required this.isSmall,
    required this.items,
    required this.controller,
    this.onChanged,
    this.label,
    this.hint,
    this.errorText,
    this.leading,
    this.fillColor = Colors.white,
    this.borderColor = const Color(0xFF1F1E5B),
    this.borderFocusColor = const Color(0xFF505050),
  });

  final bool isSmall;
  final List<Map<String, String>> items;
  final TextEditingController controller;
  final VoidCallback? onChanged;
  final String? label;
  final String? hint;
  final String? errorText;
  final IconData? leading;
  final Color fillColor;
  final Color borderColor;
  final Color borderFocusColor;

  @override
  State<ResponsiveDropdown<T>> createState() => _ResponsiveDropdownState<T>();
}

class _ResponsiveDropdownState<T> extends State<ResponsiveDropdown<T>> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue =
        widget.controller.text.isNotEmpty ? widget.controller.text : null;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _focusNode.requestFocus(),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: hasError ? const Color(0xFFFFEDED) : widget.fillColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _getColor(), width: _isFocused ? 2 : 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 6,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: widget.isSmall ? 16 : 20),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: false,
                value: _selectedValue,
                icon: const Icon(Icons.arrow_drop_down),
                style: TextStyle(
                  fontSize: widget.isSmall ? 16 : 18,
                  color: Colors.grey[800],
                ),
                hint: Text(
                  widget.hint ?? '',
                  style: TextStyle(color: _getColor()),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectedValue = newValue;
                    widget.controller.text = newValue!;
                  });
                  widget.onChanged?.call();
                },
                items:
                    widget.items.map((item) {
                      return DropdownMenuItem<String>(
                        value: item['value'],
                        child: Text(item['label']!),
                      );
                    }).toList(),
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
