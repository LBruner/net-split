import 'package:flutter/material.dart';
import 'package:net_split/src/widgets/UI/custom_scaffold.dart';
import 'package:net_split/src/widgets/results_card.dart';

class ResultadosScreen extends StatelessWidget {
  const ResultadosScreen({
    super.key,
    required this.ip,
    required this.mask,
    required this.cidr,
  });

  final String ip;
  final String mask;
  final String cidr;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: ResultsCard());
  }
}
