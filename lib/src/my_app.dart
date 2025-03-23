import 'package:flutter/material.dart';
import 'package:net_split/src/calculadora/calculadora_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: CalculadoraScreen()));
  }
}
