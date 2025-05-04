import 'package:flutter/material.dart';

class ResponsiveDatePicker extends StatefulWidget {
  const ResponsiveDatePicker({
    super.key,
    required this.controller,
    this.onChanged,
    required this.isSmall,
    this.label,
    this.hint,
    this.errorText,
    this.leading,
    this.fillColor = Colors.white,
    this.borderColor = const Color(0xFF1F1E5B),
    this.borderFocusColor = const Color(0xFF505050),
  });

  final bool isSmall;
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
  State<ResponsiveDatePicker> createState() => _ResponsiveDatePickerState();
}

class _ResponsiveDatePickerState extends State<ResponsiveDatePicker> {
  bool _isFocused = false;

  Future<void> _pickDate() async {
    DateTime? initialDate;
    final parts = widget.controller.text.split('-');
    if (parts.length == 3) {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      initialDate = DateTime(year, month, day);
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: const Color(0xFF1F1E5B),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1F1E5B),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Color(0xFF1F1E5B)),
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.controller.text = "${picked.day}/${picked.month}/${picked.year}";
      widget.onChanged?.call();
    }
  }

  void _clearDate() {
    setState(() {
      widget.controller.text = "";
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
        Stack(
          alignment: Alignment.centerRight,
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
              child: GestureDetector(
                onTap: () async {
                  setState(() => _isFocused = true);
                  await _pickDate();
                  setState(() => _isFocused = false);
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: widget.label,
                    hintText: widget.hint,
                    hintStyle: TextStyle(color: _getColor()),
                    labelStyle: TextStyle(color: _getColor()),
                    floatingLabelStyle: TextStyle(color: _getColor()),
                    filled: true,

                    fillColor:
                        hasError ? const Color(0xFFFFEDED) : widget.fillColor,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: widget.isSmall ? 18 : 20,
                      vertical: widget.isSmall ? 12 : 16,
                    ),
                    prefixIcon:
                        widget.leading != null
                            ? Icon(
                              widget.leading,
                              size: widget.isSmall ? 20 : 28,
                            )
                            : null,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _getColor()),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _getColor(), width: 2.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    widget.controller.text.isNotEmpty
                        ? widget.controller.text
                        : widget.hint ?? '',
                    style: TextStyle(
                      fontSize: widget.isSmall ? 16 : 18,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: widget.isSmall ? 12 : 16),
              child: IconButton(
                onPressed: () async {
                  if (widget.controller.text.isNotEmpty) {
                    _clearDate();
                  } else {
                    setState(() => _isFocused = true);
                    await _pickDate();
                    setState(() => _isFocused = false);
                  }
                },
                icon: Icon(
                  widget.controller.text.isNotEmpty
                      ? Icons.clear_outlined
                      : Icons.date_range_rounded,
                  color: const Color(0xFF1F1E5B),
                ),
              ),
            ),
          ],
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
