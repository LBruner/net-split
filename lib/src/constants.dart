import 'package:flutter/material.dart';
import 'package:net_split/src/colors.dart';
import 'package:intl/intl.dart';

const double kDefaultPadding = 12.0;
const double kDefaultFontSizeSmall = 12.0;
const double kDefaultFontSizeMedium = 14.0;
const double kDefaultFontSizeLarge = 16.0;
const double kDefaultFontSizeExtraLarge = 20.0;
const String kVersao = "alpha0.1";

final errorBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.red, width: 1.5),
  borderRadius: BorderRadius.circular(10),
);

final normalBorder = OutlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.circular(10),
);

OutlineInputBorder outlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.white12),
  );
}

OutlineInputBorder outlineInputBorderFocused(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: focusColor, width: 1),
  );
}

String formatNumber(int number) {
  return NumberFormat('#,###').format(number);
}
