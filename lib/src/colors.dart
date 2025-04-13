import 'package:flutter/material.dart';

// Cores
const primaryColor = Color(0xFF2697FF);
const focusColor = Color(0xFF47B19F);
const secondaryColor = Color(0xFF2F3136);
const bgColor = Color(0xFF202225);
const fontColor = Color(0xFFFFFFFF);
const resultsFontColor = Color.fromARGB(255, 170, 140, 221);
const resultsFontColorDark = Colors.blue;
const headerFontColorDark = Colors.blue;
const headerFontColor = Colors.blue;
const secondaryColorLight = Color(0xFFe4e4e4);
const bgColorLight = Color(0xFFFFFFFF);
const fontColorLight = Color(0xFF040411);
const bloquedColor = Color(0xffeb5757);
const activeColor = Color(0xff2D9CDB);
const inactiveColor = Color(0xffF2994A);
const textColor = Color(0xff7B7B7B);
const introDots = Color(0xFFBDBDBD);
const orcamentoColor = Color(0xffF2994A);
const prevendaColor = Color(0xff2D9CDB);
const vendaColor = Color(0xff219653);
const promoColor = Color(0xffeb5757);

// Shaders
final Shader linearGradient = const LinearGradient(
  colors: <Color>[primaryColor, focusColor],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

final Shader blackShader = const LinearGradient(
  colors: <Color>[Colors.black, Colors.black],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

final Shader whiteShader = const LinearGradient(
  colors: <Color>[Colors.white, Colors.white],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

// Sombras
final List<BoxShadow> lightShadows = [
  BoxShadow(
    color: Colors.grey.shade200,
    blurRadius: 20,
    offset: const Offset(0, 10),
  ),
];

final List<BoxShadow> darkShadows = [
  const BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(2, 2)),
];
