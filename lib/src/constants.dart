import 'package:flutter/material.dart';
import 'package:net_split/src/colors.dart';

const double kDefaultPadding = 12.0;
const double kDefaultFontSizeSmall = 12.0;
const double kDefaultFontSizeMedium = 14.0;
const double kDefaultFontSizeLarge = 16.0;
const double kDefaultFontSizeExtraLarge = 20.0;
const String kVersao = "alpha0.1";

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
