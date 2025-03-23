import 'package:flutter/material.dart';
import 'package:net_split/src/models/calculadora_model.dart';
import 'package:net_split/src/widgets/subnet_mask_picker.dart';

class CalculadoraBody extends StatefulWidget {
  const CalculadoraBody({super.key});

  @override
  State<CalculadoraBody> createState() => _CalculadoraBodyState();
}

class _CalculadoraBodyState extends State<CalculadoraBody> {
  String inputIp = '192.168.1.1';
  String inputMask = '255.255.255.0';

  void onChangeMask(String newMask) {
    setState(() {
      inputMask = newMask;
    });
  }

  void calculateSubnet() {
    final SubnetCalculator calculator = SubnetCalculator(inputIp, inputMask);
    calculator.printAll();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubnetMaskPicker(inputMask: inputMask, onChangeMask: onChangeMask),
        ElevatedButton(onPressed: calculateSubnet, child: Text("Calculate")),
      ],
    );
  }
}
