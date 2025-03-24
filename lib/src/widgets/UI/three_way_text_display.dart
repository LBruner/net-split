import 'package:flutter/material.dart';
import 'package:net_split/src/colors.dart';
import 'package:net_split/src/widgets/UI/custom_text.dart';

class ThreeWayTextDisplay extends StatelessWidget {
  const ThreeWayTextDisplay({
    super.key,
    required this.topLeftText,
    required this.topRightText,
    required this.underText,
  });

  final String topLeftText;
  final String topRightText;
  final String underText;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              topLeftText,
              color: isDark ? resultsFontColor : resultsFontColorDark,
              fontWeight: FontWeight.w500,
            ),
            CustomText(topRightText, letterSpacing: 3),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Text(
          underText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: MediaQuery.of(context).size.width * 0.0365,
          ),
        ),
        Divider(color: isDark ? Colors.grey : Colors.black),
      ],
    );
  }
}
