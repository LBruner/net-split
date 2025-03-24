import 'package:flutter/material.dart';
import 'dart:math';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SubnetMaskPicker extends StatefulWidget {
  const SubnetMaskPicker({
    super.key,
    required this.inputMask,
    required this.onChangeMask,
  });

  final Function(String newMask) onChangeMask;
  final String inputMask;
  @override
  SubnetCalculatorScreenState createState() => SubnetCalculatorScreenState();
}

class SubnetCalculatorScreenState extends State<SubnetMaskPicker> {
  double cidr = 24;

  String get subnetMask => _calculateMaskFromCIDR(cidr.toInt());
  int get networkBits => cidr.toInt();
  int get hostBits => 32 - networkBits;
  int get totalHosts =>
      pow(2, hostBits).toInt() - 2; // Subtracting network & broadcast addresses

  String _calculateMaskFromCIDR(int cidr) {
    String binaryMask = '1' * cidr + '0' * (32 - cidr);
    List<int> maskParts = [
      int.parse(binaryMask.substring(0, 8), radix: 2),
      int.parse(binaryMask.substring(8, 16), radix: 2),
      int.parse(binaryMask.substring(16, 24), radix: 2),
      int.parse(binaryMask.substring(24, 32), radix: 2),
    ];
    return maskParts.join('.');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),

        Text(
          "Máscara de Subnet: $subnetMask",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Bits de rede: $networkBits",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text("Redes: ${pow(2, cidr).toInt()}"),
                  ],
                ),
                Column(
                  children: [
                    Text("Host Bits: $hostBits"),
                    Text("Hosts: $totalHosts"),
                  ],
                ),
              ],
            ),
          ),
        ),
        Text('Tamanho do Prefixo: '),
        SfSliderTheme(
          data: SfSliderThemeData(tooltipBackgroundColor: Colors.red[300]),
          child: SfSlider(
            value: cidr,
            activeColor: Colors.pink,
            stepSize: 1,
            showDividers: true,
            enableTooltip: true,
            showTicks: true,
            interval: 8,
            showLabels: true,
            minorTicksPerInterval: 7,
            min: 0,
            max: 32,
            onChanged: (value) {
              setState(() {
                cidr = value;
              });
              widget.onChangeMask(subnetMask);
            },
          ),
        ),
      ],
    );
  }
}
