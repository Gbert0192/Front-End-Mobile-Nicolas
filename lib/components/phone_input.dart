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

class ResponsiveTextInput extends StatefulWidget {
  const ResponsiveTextInput({
    super.key,
    required this.isSmall,
    this.controller,
    this.onChanged,
    this.hint,
    this.label,
    this.errorText,
  });

  final bool isSmall;
  final TextEditingController? controller;
  final VoidCallback? onChanged;
  final String? hint;
  final String? label;
  final String? errorText;

  @override
  State<ResponsiveTextInput> createState() => _ResponsiveTextInputState();
}

class _ResponsiveTextInputState extends State<ResponsiveTextInput> {
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
    if (_isFocused) return const Color(0xFF1F1E5B);
    return const Color(0xFF505050);
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
            controller: widget.controller,
            countries:
                countries
                    .where((c) => allowedCountryCodes.contains(c.code))
                    .toList(),
            decoration: InputDecoration(
              labelText: widget.label ?? 'Phone Number',
              hintText: widget.hint ?? 'Phone Number',
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: const BorderSide(),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              filled: true,
              fillColor:
                  widget.errorText != null
                      ? const Color(0xFFFFEDED)
                      : Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
            initialCountryCode: 'ID',
            disableLengthCheck: true,
            focusNode: _focusNode,
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
