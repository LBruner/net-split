import 'package:flutter/material.dart';
import 'package:net_split/src/constants.dart';

class IpPicker extends StatefulWidget {
  final String inputIp;
  final Function(String) onChangeIpAddress;

  final String? inputIpError;

  const IpPicker({
    super.key,
    required this.inputIp,
    required this.onChangeIpAddress,
    required this.inputIpError,
  });

  @override
  IpPickerState createState() => IpPickerState();
}

class IpPickerState extends State<IpPicker> {
  late TextEditingController _ipController;
  String _lastText = '';

  @override
  void initState() {
    super.initState();
    _lastText = widget.inputIp;
    _ipController = TextEditingController(text: widget.inputIp);
  }

  @override
  void didUpdateWidget(IpPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.inputIp != oldWidget.inputIp &&
        widget.inputIp != _ipController.text) {
      _ipController.text = widget.inputIp;
      _lastText = widget.inputIp;
    }
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  String _formatIpAddress(String input, int cursorPos) {
    if (input.isEmpty) return '';

    String cleaned = input.replaceAll(RegExp(r'[^\d\.]'), '');

    if (cleaned.length < _lastText.length) {
      _lastText = cleaned;
      return cleaned;
    }

    List<String> parts = cleaned.split('.');

    List<String> result = [];
    for (int i = 0; i < parts.length && i < 4; i++) {
      String part = parts[i];

      if (part.length > 3) {
        if (cursorPos >= input.length) {
          result.add(part.substring(0, 3));
          part = part.substring(3);
          if (part.isNotEmpty && result.length < 3) {
            result.add(part);
          }
        } else {
          result.add(part);
        }
      } else {
        result.add(part);
      }

      if (result.isNotEmpty && result.last.isNotEmpty) {
        int num = int.tryParse(result.last) ?? 0;
        if (num > 255) result.last = '255';
        if (num < 0) result.last = '0';
      }
    }

    String newText = result.take(4).join('.');

    if (input.endsWith('.') && result.length < 4 && !newText.endsWith('.')) {
      newText += '.';
    }

    _lastText = newText;
    return newText;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.56,
          child: TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: _ipController,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              letterSpacing: 2,
              color: widget.inputIpError != null ? Colors.red : null,
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
                  widget.inputIpError != null ? errorBorder : normalBorder,
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
              hintText: "Ex: 192.168.1.1",
              hintStyle: TextStyle(
                color: isDark ? Colors.grey : Colors.grey[600],
                fontSize: 17,
              ),
              errorText: widget.inputIpError,
              errorStyle: TextStyle(height: 0.8),
              contentPadding: EdgeInsets.all(12),
            ),
            onChanged: (value) {
              final cursorPos = _ipController.selection.base.offset;
              final formatted = _formatIpAddress(value, cursorPos);

              if (formatted != value) {
                int newCursorPos =
                    cursorPos + (formatted.length - value.length);
                newCursorPos = newCursorPos.clamp(0, formatted.length);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _ipController.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(offset: newCursorPos),
                  );
                });
              }
              widget.onChangeIpAddress(formatted);
            },
          ),
        ),
      ],
    );
  }
}
