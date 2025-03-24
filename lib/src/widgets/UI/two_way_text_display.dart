import 'package:flutter/material.dart';
import 'package:net_split/src/colors.dart';
import 'package:net_split/src/widgets/UI/custom_text.dart';

class TwoWayTextDisplay extends StatelessWidget {
  const TwoWayTextDisplay({
    super.key,
    required this.leftText,
    required this.rightText,
    this.showDivider = true,
  });

  final String leftText;
  final String rightText;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                leftText,
                color: isDark ? resultsFontColor : resultsFontColorDark,
              ),
              CustomText(rightText, letterSpacing: 1),
            ],
          ),
          if (showDivider) Divider(color: isDark ? Colors.grey : Colors.black),
        ],
      ),
    );
  }
}
