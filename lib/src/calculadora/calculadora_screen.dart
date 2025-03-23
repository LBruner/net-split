import 'package:flutter/material.dart';
import 'package:net_split/src/calculadora/calculadora_body.dart';
import 'package:net_split/src/models/calculadora_model.dart';
import 'package:net_split/src/widgets/subnet_mask_picker.dart';

class CalculadoraScreen extends StatelessWidget {
  const CalculadoraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var subnet = SubnetCalculator("192.168.1.10", "255.255.255.0");
    subnet.printAll();
    return CalculadoraBody();
  }
}
