import 'package:flutter/material.dart';
import 'package:tugas_front_end_nicolas/components/text_input.dart';

enum DatePickerType { date, time, datetime }

class ResponsiveTimePicker extends StatefulWidget {
  const ResponsiveTimePicker({
    super.key,
    this.controller,
    this.onChanged,
    required this.isSmall,
    this.label,
    this.hint,
    this.errorText,
    this.isLoading,
    this.leading,
    this.fillColor = Colors.white,
    this.borderColor = const Color(0xFF1F1E5B),
    this.borderFocusColor = const Color(0xFF505050),
    this.mode = StyleMode.outline,
    this.type = DatePickerType.date,
  });

  final bool isSmall;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? label;
  final String? hint;
  final String? errorText;
  final IconData? leading;
  final Color fillColor;
  final Color borderColor;
  final Color borderFocusColor;
  final StyleMode mode;
  final DatePickerType type;
  final bool? isLoading;

  @override
  State<ResponsiveTimePicker> createState() => _ResponsiveTimePickerState();
}

class _ResponsiveTimePickerState extends State<ResponsiveTimePicker> {
  bool _isFocused = false;
  String? _selectedDate;

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    DateTime? initialDate;

    if (widget.controller != null && widget.controller!.text.isNotEmpty) {
      try {
        final text = widget.controller!.text;
        if (widget.type == DatePickerType.datetime) {
          final dateTimeParts = text.split(' ');
          final dateParts = dateTimeParts[0].split('/');
          final timeParts = dateTimeParts[1].split(':');

          final day = int.parse(dateParts[0]);
          final month = int.parse(dateParts[1]);
          final year = int.parse(dateParts[2]);
          final hour = int.parse(timeParts[0]);
          final minute = int.parse(timeParts[1]);

          initialDate = DateTime(year, month, day, hour, minute);
        } else {
          final parts = widget.controller!.text.split('/');
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          initialDate = DateTime(year, month, day);
        }
      } catch (_) {}
    }

    initialDate ??= now;

    if (widget.type == DatePickerType.time) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (pickedTime != null) {
        final formattedTime =
            "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
        _selectedDate = formattedTime;
        if (widget.controller != null) {
          widget.controller?.text = formattedTime;
        }
        widget.onChanged?.call(formattedTime);
      }
      return;
    }

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
          initialTime: TimeOfDay.fromDateTime(initialDate),
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
        case DatePickerType.datetime:
          formatted =
              "${finalDate.day}/${finalDate.month}/${finalDate.year}:${finalDate.hour.toString().padLeft(2, '0')}:${finalDate.minute.toString().padLeft(2, '0')}";
          break;
        default:
          formatted = '';
          break;
      }

      _selectedDate = formatted;
      if (widget.controller != null) {
        widget.controller?.text = formatted;
      }
      widget.onChanged?.call(formatted);
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
  void initState() {
    super.initState();
    _selectedDate =
        widget.controller != null
            ? widget.controller!.text.isNotEmpty
                ? widget.controller!.text
                : null
            : null;
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
                        ? [
                          BoxShadow(
                            color: Colors.black.withAlpha(64),
                            blurRadius: 6,
                            offset: const Offset(4, 4),
                          ),
                        ]
                        : null,
              ),
              child: GestureDetector(
                onTap: () async {
                  if (widget.isLoading != null ? !widget.isLoading! : true) {
                    setState(() => _isFocused = true);
                    await _pickDate();
                    setState(() => _isFocused = false);
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    enabled:
                        widget.isLoading != null ? !widget.isLoading! : true,
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
                    _selectedDate ?? widget.hint ?? '',
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
                  if (_selectedDate != null ||
                      (widget.controller?.text.isNotEmpty ?? false)) {
                    _clearDate();
                  } else {
                    setState(() => _isFocused = true);
                    await _pickDate();
                    setState(() => _isFocused = false);
                  }
                },
                icon: Icon(
                  _selectedDate != null ||
                          (widget.controller?.text.isNotEmpty ?? false)
                      ? Icons.clear_outlined
                      : widget.type == DatePickerType.time
                      ? Icons.access_time
                      : Icons.calendar_month_sharp,
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
