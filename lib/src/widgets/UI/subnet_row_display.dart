import 'package:flutter/material.dart';
import 'package:net_split/src/constants.dart';
import 'package:net_split/src/widgets/UI/custom_text.dart';

class SubnetRowDisplay extends StatelessWidget {
  const SubnetRowDisplay({
    required this.topLeftText,
    required this.topRightText,
    required this.bottomLeftText,
    required this.bottomRightText,
    required this.alignment,
    required this.lightColor,
    required this.darkColor,
    super.key,
  });

  final String topLeftText;
  final int topRightText;
  final String bottomLeftText;
  final int bottomRightText;
  final Color lightColor;
  final Color darkColor;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: alignment,
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isDark ? darkColor : lightColor,
          ),
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              children: [
                CustomText(
                  topLeftText,
                  color:
                      isDark
                          ? Color.fromRGBO(131, 164, 255, 1)
                          : Color.fromRGBO(55, 94, 201, 1),
                ),
                CustomText(topRightText.toString()),
              ],
            ),
            Row(
              children: [
                CustomText(
                  bottomLeftText,
                  color:
                      isDark
                          ? Color.fromRGBO(131, 164, 255, 1)
                          : Color.fromRGBO(55, 94, 201, 1),
                ),
                CustomText(formatNumber(bottomRightText)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
