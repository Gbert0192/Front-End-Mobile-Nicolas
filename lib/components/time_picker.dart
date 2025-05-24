import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';

enum DatePickerType { date, month, datetime }

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
    this.mode = StyleMode.outline,
    this.type = DatePickerType.date,
  });

  final bool isSmall;
  final TextEditingController? controller;
  final VoidCallback? onChanged;
  final String? label;
  final String? hint;
  final String? errorText;
  final IconData? leading;
  final Color fillColor;
  final Color borderColor;
  final Color borderFocusColor;
  final StyleMode mode;
  final DatePickerType type;

  @override
  State<ResponsiveDatePicker> createState() => _ResponsiveDatePickerState();
}

class _ResponsiveDatePickerState extends State<ResponsiveDatePicker> {
  bool _isFocused = false;
  String? _selectedDate;

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    DateTime? initialDate;

    if (widget.controller != null && widget.controller!.text.isNotEmpty) {
      try {
        final parts = widget.controller!.text.split('/');
        if (widget.type == DatePickerType.month && parts.length >= 2) {
          final month = int.parse(parts[0]);
          final year = int.parse(parts[1]);
          initialDate = DateTime(year, month);
        } else if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          initialDate = DateTime(year, month, day);
        }
      } catch (_) {}
    }

    initialDate ??= now;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
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

    if (pickedDate != null) {
      DateTime finalDate = pickedDate;

      if (widget.type == DatePickerType.datetime) {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(pickedDate),
        );
        if (time != null) {
          finalDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            time.hour,
            time.minute,
          );
        }
      }

      String formatted;
      switch (widget.type) {
        case DatePickerType.date:
          formatted = "${finalDate.day}/${finalDate.month}/${finalDate.year}";
          break;
        case DatePickerType.month:
          formatted = "${finalDate.month}/${finalDate.year}";
          break;
        case DatePickerType.datetime:
          formatted =
              "${finalDate.day}/${finalDate.month}/${finalDate.year} ${finalDate.hour.toString().padLeft(2, '0')}:${finalDate.minute.toString().padLeft(2, '0')}";
          break;
      }

      _selectedDate = formatted;
      widget.controller?.text = formatted;
      widget.onChanged?.call();
    }
  }

  void _clearDate() {
    setState(() {
      _selectedDate = null;
      widget.controller?.clear();
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
    final isOutline = widget.mode == StyleMode.outline;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            widget.mode == StyleMode.underline
                ? Text(
                  widget.label ?? '',
                  style: TextStyle(
                    color: _getColor(),
                    fontSize: widget.isSmall ? 12 : 16,
                  ),
                )
                : const SizedBox.shrink(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow:
                    isOutline
                        ? null
                        : [
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
                    enabledBorder:
                        isOutline
                            ? OutlineInputBorder(
                              borderSide: BorderSide(color: _getColor()),
                              borderRadius: BorderRadius.circular(20),
                            )
                            : UnderlineInputBorder(
                              borderSide: BorderSide(color: _getColor()),
                            ),
                    focusedBorder:
                        isOutline
                            ? OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _getColor(),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            )
                            : UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: _getColor(),
                                width: 2.0,
                              ),
                            ),
                    errorBorder:
                        isOutline
                            ? OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20),
                            )
                            : const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                  ),
                  child: Text(
                    _selectedDate ??
                        widget.controller?.text ??
                        widget.hint ??
                        '',
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
                  if (_selectedDate != null) {
                    _clearDate();
                  } else {
                    setState(() => _isFocused = true);
                    await _pickDate();
                    setState(() => _isFocused = false);
                  }
                },
                icon: Icon(
                  _selectedDate != null
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
