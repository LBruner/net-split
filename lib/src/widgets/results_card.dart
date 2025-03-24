import 'package:flutter/material.dart';
import 'package:net_split/src/models/calculadora_model.dart';
import 'package:net_split/src/widgets/UI/custom_text.dart';
import 'package:net_split/src/widgets/UI/three_way_text_display.dart';
import 'package:net_split/src/widgets/UI/two_way_text_display.dart';

class ResultsCard extends StatelessWidget {
  const ResultsCard(this.calculator, {super.key});

  final SubnetCalculator calculator;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.share),
                Center(child: CustomText('Resultados')),
                Container(),
              ],
            ),
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
            TwoWayTextDisplay(leftText: 'Tamanho do Bloco', rightText: '1'),
            TwoWayTextDisplay(
              leftText: 'CIDR',
              rightText: calculator.getCIDRNotation(),
            ),
            TwoWayTextDisplay(
              leftText: 'Bits de Host',
              rightText: calculator.getShortNotation().toString(),
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
              leftText: 'Endereço de Rede',
              rightText:
                  '${calculator.getNetworkAddress()}${calculator.getCIDRNotation()}',
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
