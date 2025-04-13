import 'package:flutter/material.dart';
import 'package:net_split/src/calculadora/calculadora_body.dart';

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  @override
  Widget build(BuildContext context) {
    return CalculadoraBody();
  }
}
