import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';

List<String> allowedCountryCodes = [
  'ID',
  'MY',
  'SG',
  'PH',
  'BN',
  'TH',
  'VN',
  'KH',
  'LA',
  'MM',
  'JP',
  'KR',
  'CN',
  'TW',
  'HK',
];

class ResponsivePhoneInput extends StatefulWidget {
  const ResponsivePhoneInput({
    super.key,
    required this.isSmall,
    this.controller,
    this.onChanged,
    this.onCountryChanged,
    this.hint,
    this.label,
    this.errorText,
    this.country_code,
    this.fillColor = Colors.white,
    this.borderColor = const Color(0xFF1F1E5B),
    this.borderFocusColor = const Color(0xFF505050),
  });

  final bool isSmall;
  final TextEditingController? controller;
  final VoidCallback? onChanged;
  final ValueChanged<Country>? onCountryChanged;
  final String? hint;
  final String? label;
  final String? errorText;
  final String? country_code;
  final Color fillColor;
  final Color borderColor;
  final Color borderFocusColor;

  @override
  State<ResponsivePhoneInput> createState() => _ResponsivePhoneInputState();
}

class _ResponsivePhoneInputState extends State<ResponsivePhoneInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;

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
          child: IntlPhoneField(
            focusNode: _focusNode,
            controller: widget.controller,
            onCountryChanged: widget.onCountryChanged,
            onChanged: (_) {
              widget.onChanged?.call();
            },
            countries:
                countries
                    .where((c) => allowedCountryCodes.contains(c.code))
                    .toList(),
            decoration: InputDecoration(
              hintText: widget.hint ?? 'Phone Number',
              labelText: widget.label ?? 'Phone Number',
              hintStyle: TextStyle(color: _getColor()),
              labelStyle: TextStyle(color: _getColor()),
              floatingLabelStyle: TextStyle(color: _getColor()),
              filled: true,
              fillColor: hasError ? const Color(0xFFFFEDED) : widget.fillColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: widget.isSmall ? 18 : 20,
                vertical: widget.isSmall ? 12 : 16,
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
            initialCountryCode: widget.country_code,
            disableLengthCheck: true,
          ),
        ),
        const SizedBox(height: 4),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
