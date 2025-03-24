import 'package:flutter/material.dart';
import 'package:net_split/src/models/calculadora_model.dart';
import 'package:net_split/src/widgets/UI/ip_picker.dart';
import 'package:net_split/src/widgets/results_card.dart';
import 'package:net_split/src/widgets/subnet_mask_picker.dart';

class CalculadoraBody extends StatefulWidget {
  const CalculadoraBody({super.key});

  @override
  State<CalculadoraBody> createState() => _CalculadoraBodyState();
}

class _CalculadoraBodyState extends State<CalculadoraBody> {
  String inputIp = '192.168.1.1';
  String inputMask = '255.255.255.0';
  SubnetCalculator? calculator;
  String? ipError; // Add this for error message

  // Add IP validation function
  bool _isValidIp(String ip) {
    final parts = ip.split('.');
    if (parts.length != 4) return false;

    for (final part in parts) {
      final number = int.tryParse(part);
      if (number == null || number < 0 || number > 255) {
        return false;
      }
    }
    return true;
  }

  void onChangeIpAddress(String newIp) {
    setState(() {
      inputIp = newIp;
      // Clear error when user types
      ipError = null;
    });
  }

  void onChangeMask(String newMask) {
    setState(() {
      inputMask = newMask;
    });
  }

  void calculateSubnet() {
    if (!_isValidIp(inputIp)) {
      setState(() {
        ipError = 'Please enter a valid IP address (e.g. 192.168.1.1)';
      });
      return;
    }

    setState(() {
      calculator = SubnetCalculator(inputIp, inputMask);
      ipError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IpPicker(
              inputIp: inputIp,
              onChangeIpAddress: onChangeIpAddress,
              inputIpError: ipError,
            ),
          ],
        ),
        SubnetMaskPicker(inputMask: inputMask, onChangeMask: onChangeMask),
        ElevatedButton(onPressed: calculateSubnet, child: Text("Calculate")),
        if (calculator != null) ResultsCard(calculator!),
      ],
    );
  }
}
