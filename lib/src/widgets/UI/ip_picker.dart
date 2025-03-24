import 'package:flutter/material.dart';

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
    return TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      controller: _ipController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        errorText: widget.inputIpError,
        hintText: "Ex: 192.168.1.1",
      ),
      onChanged: (value) {
        final cursorPos = _ipController.selection.base.offset;
        final formatted = _formatIpAddress(value, cursorPos);

        if (formatted != value) {
          int newCursorPos = cursorPos + (formatted.length - value.length);
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
    );
  }
}
