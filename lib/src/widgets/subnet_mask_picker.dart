import 'package:flutter/material.dart';
import 'package:net_split/src/colors.dart';
import 'package:net_split/src/widgets/UI/custom_text.dart';
import 'package:net_split/src/widgets/UI/subnet_row_display.dart';
import 'dart:math';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SubnetMaskPicker extends StatefulWidget {
  const SubnetMaskPicker({
    super.key,
    required this.inputMask,
    required this.onChangeMask,
    required this.cidr,
    required this.onChangeCidr,
  });

  final Function(String newMask) onChangeMask;
  final String inputMask;
  final int cidr;
  final Function(int newCidr) onChangeCidr;
  @override
  SubnetCalculatorScreenState createState() => SubnetCalculatorScreenState();
}

class SubnetCalculatorScreenState extends State<SubnetMaskPicker> {
  @override
  void initState() {
    super.initState();
  }

  String get subnetMask => _calculateMaskFromCIDR(widget.cidr);
  int get networkBits => widget.cidr.toInt();
  int get hostBits => 32 - networkBits;
  int get totalHosts {
    if (widget.cidr == 32) return 1;
    if (widget.cidr == 31) return 2;
    return pow(2, hostBits).toInt() - 2;
  }

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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),

        Row(
          children: [
            CustomText(
              'Máscara de Subnet: ',
              color: resultsFontColorDark,
              fontWeight: FontWeight.w600,
            ),
            Text(
              _calculateMaskFromCIDR(widget.cidr),
              style: TextStyle(fontSize: 16, fontFamily: 'monospace'),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.004),
        Card(
          color: isDark ? const Color.fromARGB(255, 41, 41, 41) : Colors.white,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SubnetRowDisplay(
                    alignment: MainAxisAlignment.start,
                    topLeftText: 'Bits de Rede: ',
                    topRightText: networkBits,
                    bottomLeftText: 'Redes: ',
                    bottomRightText: pow(2, widget.cidr).toInt(),
                    lightColor: Colors.redAccent,
                    darkColor: Colors.redAccent,
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: SubnetRowDisplay(
                    alignment: MainAxisAlignment.end,
                    topLeftText: 'Bits Host: ',
                    topRightText: hostBits,
                    bottomLeftText: 'Hosts: ',
                    bottomRightText: totalHosts,
                    darkColor: Colors.orangeAccent,
                    lightColor: Colors.orangeAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CustomText(
          'Tamanho do Prefixo: ',
          color: Colors.blue,
          fontWeight: FontWeight.w600,
        ),
        SfSliderTheme(
          data: SfSliderThemeData(
            tooltipBackgroundColor: Colors.redAccent,
            tooltipTextStyle: TextStyle(color: Colors.white),
          ),
          child: SfSlider(
            tooltipShape: SfPaddleTooltipShape(),
            activeColor: Colors.pink,
            inactiveColor: Colors.orangeAccent,
            stepSize: 1,
            showDividers: true,
            enableTooltip: true,
            showTicks: true,
            interval: 8,
            showLabels: true,
            minorTicksPerInterval: 7,
            min: 0,
            max: 32,
            value: widget.cidr.toDouble(),
            onChanged: (value) {
              if (value == 0) return;
              final int newCidr = value.toInt();
              // Calculate mask with the NEW cidr value, not the old one
              String newMask = _calculateMaskFromCIDR(newCidr);
              widget.onChangeMask(newMask);
              widget.onChangeCidr(newCidr);
            },
          ),
        ),
      ],
    );
  }
}
