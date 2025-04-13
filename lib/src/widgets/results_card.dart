import 'package:flutter/material.dart';
import 'package:net_split/src/models/calculadora_model.dart';
import 'package:net_split/src/shared/controllers/providers/provider.dart';
import 'package:net_split/src/widgets/UI/custom_text.dart';
import 'package:net_split/src/widgets/UI/three_way_text_display.dart';
import 'package:net_split/src/widgets/UI/two_way_text_display.dart';
import 'package:provider/provider.dart';

String cidrToMask(int cidr) {
  if (cidr < 0 || cidr > 32)
    return '255.255.255.0'; // Default for invalid input

  // Calculate binary mask
  int fullMask = (0xFFFFFFFF << (32 - cidr)) & 0xFFFFFFFF;

  // Convert to dotted decimal notation
  return [
    (fullMask >> 24) & 0xFF,
    (fullMask >> 16) & 0xFF,
    (fullMask >> 8) & 0xFF,
    fullMask & 0xFF,
  ].join('.');
}

class ResultsCard extends StatelessWidget {
  const ResultsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final calculatorState =
        context.watch<CalculatorState>(); // Watch for state changes
    final String ip = calculatorState.inputIp;
    final String mask = cidrToMask(calculatorState.inputCidr);

    print("Building ResultsCard with mask: $mask");
    print("Building ResultsCard with ip: $ip");

    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final SubnetCalculator calculator = SubnetCalculator(ip, mask);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color.fromARGB(255, 41, 41, 41) : Colors.white,
        border: Border.all(
          width: 0.5,
          color:
              isDark
                  ? Colors.transparent
                  : const Color.fromARGB(255, 192, 192, 192),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    'Resultados',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.deepPurpleAccent : Colors.blue,
                  ),
                ),
              ],
            ),
            Divider(),
            ThreeWayTextDisplay(
              topLeftText: 'Endereço Ip',
              topRightText: '${calculator.ip}${calculator.getCIDRNotation()}',
              underText: calculator.getBinaryID(),
            ),
            ThreeWayTextDisplay(
              topLeftText: 'Máscara Subnet',
              topRightText: calculator.mask,
              underText: calculator.getBinarySubnetMask(),
            ),
            ThreeWayTextDisplay(
              topLeftText: 'Máscara Wildcard',
              topRightText: calculator.getWildcardMask(),
              underText: calculator.getFirstBinaryWildcardMask(),
            ),
            TwoWayTextDisplay(
              leftText: 'Hosts Totais',
              rightText: calculator.getTotalHosts().toString(),
            ),
            TwoWayTextDisplay(
              leftText: 'Hosts Utilizáveis',
              rightText: calculator.getUsableHosts().toString(),
            ),
            TwoWayTextDisplay(
              leftText: 'Primeiro IP',
              rightText: calculator.getFirstUsableIP(),
            ),
            TwoWayTextDisplay(
              leftText: 'Último IP',
              rightText: calculator.getLastUsableIP(),
            ),
            TwoWayTextDisplay(
              leftText: 'Classe do IP',
              rightText: calculator.getIPClass(),
            ),
            TwoWayTextDisplay(
              leftText: 'Broadcast',
              rightText: calculator.getBroadcastAddress(),
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}
