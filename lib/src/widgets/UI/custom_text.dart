import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:net_split/src/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double? letterSpacing;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign textAlign;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.textAlign = TextAlign.start,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        color: color ?? (isDark ? Colors.white : fontColorLight),
      ),
    );
  }
}
