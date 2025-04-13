import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_split/src/constants.dart';
import 'package:net_split/src/widgets/UI/custom_text.dart';

class CidrPicker extends StatefulWidget {
  const CidrPicker({
    super.key,
    required this.inputCidr,
    required this.onChangeCidr,
    required this.onValidate,
    this.errorText,
  });

  final int inputCidr;
  final Function(int) onChangeCidr;
  final Function(String)? onValidate;

  final String? errorText;

  @override
  State<CidrPicker> createState() => _CidrPickerState();
}

class _CidrPickerState extends State<CidrPicker> {
  late TextEditingController _cidrController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _cidrController = TextEditingController(
      text: widget.inputCidr.toStringAsFixed(0),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handleInputChange(String value) {
    _debounceTimer?.cancel();

    final cidr = int.tryParse(value) ?? 0;
    widget.onChangeCidr(cidr);

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (widget.onValidate != null) {
        widget.onValidate!(value);
      }
    });
  }

  @override
  void didUpdateWidget(CidrPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.inputCidr != oldWidget.inputCidr) {
      _cidrController.text = widget.inputCidr.toStringAsFixed(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 14,
                ),
                child: CustomText('/', fontSize: 20),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.28,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _cidrController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  letterSpacing: 2,
                  color: widget.errorText != null ? Colors.red : null,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      isDark
                          ? const Color.fromARGB(255, 41, 41, 41)
                          : const Color.fromARGB(255, 240, 240, 240),
                  border: normalBorder,
                  enabledBorder: normalBorder,
                  focusedBorder:
                      widget.errorText != null ? errorBorder : normalBorder,
                  errorBorder: errorBorder,
                  focusedErrorBorder: errorBorder,
                  hintText: "1 até 32",
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey : Colors.grey[600],
                    fontSize: 17,
                  ),
                  errorText: widget.errorText,
                  errorStyle: TextStyle(height: 0.8),
                  contentPadding: EdgeInsets.all(12),
                  isDense: true,
                ),
                onChanged: _handleInputChange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
